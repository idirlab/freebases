#!/bin/bash

set -e

USERNAME=$1
PASSWORD=$2

#removing triples
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE freebase_clean SELECT * FROM freebase WHERE subject REGEXP '^/m/|^/g/' AND object REGEXP '^/m/|^/g/' AND predicate NOT REGEXP '^/common/|^/key/|^/type/|^/kg/|^/base/|^/freebase/|^/dataworld/|^/topic_server/|^/user/|^/pipeline/|^/kp_lw/|^rdf|^owl'"
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE INDEX idx_predicate ON freebase_clean(predicate)"

#create datagraph
mysql -u $USERNAME -p$PASSWORD freebase -e "SET @max_id = (SELECT MAX(id) FROM entities_id_label); SET @sql = CONCAT('ALTER TABLE properties_id_label AUTO_INCREMENT = ', @max_id + 1); PREPARE st FROM @sql; EXECUTE st"
mysql -u $USERNAME -p$PASSWORD freebase -e "ALTER TABLE properties_id_label ADD id INT AUTO_INCREMENT PRIMARY KEY"
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE INDEX idx_mid ON entities_id_label(mid)" &
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE INDEX idx_predicate ON properties_id_label(label(150))" &
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE INDEX idx_all ON freebase_clean(subject, predicate, object(150))" &
wait
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE freebase_datagraph SELECT DISTINCT e1.id AS subject, p.id AS predicate, e2.id AS object FROM freebase_clean f JOIN properties_id_label p JOIN entities_id_label e1 JOIN entities_id_label e2 WHERE (f.subject=e1.mid AND f.object=e2.mid AND f.predicate=p.label)"

#select most specific source/object type for an edgetype
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE distinct_entities_subject SELECT DISTINCT predicate, subject FROM freebase_datagraph" &
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE distinct_entities_object SELECT DISTINCT predicate, object FROM freebase_datagraph" &
wait
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE distinct_entities_subject_cnt SELECT predicate, COUNT(*) as count FROM distinct_entities_subject GROUP BY predicate" &
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE distinct_entities_object_cnt SELECT predicate, COUNT(*) as count FROM distinct_entities_object GROUP BY predicate" &
wait
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE INDEX idx_predicate ON distinct_entities_subject(predicate)" &
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE INDEX idx_subject ON distinct_entities_subject(subject)" &
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE INDEX idx_predicate ON distinct_entities_object(predicate)" &
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE INDEX idx_object ON distinct_entities_object(object)" &
wait
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE INDEX idx_label ON types_id_label(label(64))"

mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE entity_types SELECT e.id AS entity, t.id AS type FROM object_types_clean o JOIN entities_id_label e JOIN types_id_label t ON (o.subject=e.mid AND t.label=o.object)"
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE INDEX idx_entity ON entity_types(entity)"
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE candidate_subject_endtypes SELECT e.predicate, t.type AS end_type, COUNT(*)/c.count AS percentage FROM distinct_entities_subject e JOIN entity_types t JOIN distinct_entities_subject_cnt c ON (e.subject=t.entity AND c.predicate=e.predicate) GROUP BY e.predicate, t.type HAVING percentage >= 0.9 ORDER BY predicate, percentage" &
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE candidate_object_endtypes SELECT e.predicate, t.type AS end_type, COUNT(*)/c.count AS percentage FROM distinct_entities_object e JOIN entity_types t JOIN distinct_entities_object_cnt c ON (e.object=t.entity AND c.predicate=e.predicate) GROUP BY e.predicate, t.type HAVING percentage >= 0.9 ORDER BY predicate, percentage"
wait
mysql -u $USERNAME -p$PASSWORD freebase -e "SET @num := 0, @type := ''; CREATE TABLE candidate_subject_endtypes_10 SELECT predicate, end_type, percentage FROM (SELECT predicate, end_type, percentage, @num := if(@type = predicate, @num + 1, 1) AS row_number, @type := predicate AS dummy FROM candidate_subject_endtypes GROUP BY predicate, end_type, percentage HAVING row_number <= 10) AS T" &
mysql -u $USERNAME -p$PASSWORD freebase -e "SET @num := 0, @type := ''; CREATE TABLE candidate_object_endtypes_10 SELECT predicate, end_type, percentage FROM (SELECT predicate, end_type, percentage, @num := if(@type = predicate, @num + 1, 1) AS row_number, @type := predicate AS dummy FROM candidate_object_endtypes GROUP BY predicate, end_type, percentage HAVING row_number <= 10) as T" &
wait
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE INDEX idx_all ON candidate_subject_endtypes_10(predicate, end_type)" &
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE INDEX idx_all ON candidate_object_endtypes_10(predicate, end_type)"
wait
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE type_cnt SELECT type, COUNT(*) AS count FROM entity_types GROUP BY type"
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE INDEX idx_type ON type_cnt(type)"
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE type_pair SELECT t1.type AS type1, t2.type AS type2, t2.count AS count2 FROM type_cnt t1 JOIN type_cnt t2"
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE INDEX idx_pair ON type_pair(type1, type2)"
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE type_pair_cnt SELECT type1, type2, COUNT(*) AS count, COUNT(*) / count2 AS ratio FROM entity_types e1 JOIN entity_types e2 JOIN type_pair ON e1.entity=e2.entity AND e1.type = type1 AND e2.type = type2 GROUP BY e1.type, e2.type, count2"
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE ranked_subject_endtypes_10 SELECT c1.predicate, t.type2 AS type, sum(ratio) AS score FROM candidate_subject_endtypes_10 c1 JOIN candidate_subject_endtypes_10 c2 JOIN type_pair_cnt t ON (c1.predicate=c2.predicate AND c1.end_type=t.type1 AND c2.end_type=t.type2) GROUP BY predicate, type ORDER BY predicate, score" &
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE ranked_object_endtypes_10 SELECT c1.predicate, t.type2 AS type, sum(ratio) AS score FROM candidate_object_endtypes_10 c1 JOIN candidate_object_endtypes_10 c2 JOIN type_pair_cnt t ON (c1.predicate=c2.predicate AND c1.end_type=t.type1 AND c2.end_type=t.type2) GROUP BY predicate, type ORDER BY predicate, score"
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE freebase_endtypes_subject SELECT r1.predicate, r1.type, r1.score FROM ranked_subject_endtypes_10 r1 LEFT JOIN ranked_subject_endtypes_10 r2 ON r1.predicate=r2.predicate AND r1.score < r2.score WHERE r2.score is NULL"
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE freebase_endtypes_object SELECT r1.predicate, r1.type, r1.score FROM ranked_object_endtypes_10 r1 LEFT JOIN ranked_object_endtypes_10 r2 ON r1.predicate=r2.predicate AND r1.score < r2.score WHERE r2.score is NULL"
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE freebase_endtypes SELECT t1.type AS subject, t1.predicate AS predicate, t2.type AS object FROM freebase_endtypes_subject As t1 JOIN freebase_endtypes_object  AS t2 ON t1.predicate=t2.predicate"


