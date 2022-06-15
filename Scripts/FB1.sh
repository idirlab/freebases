
#removing triples
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE freebase_clean SELECT * FROM freebase WHERE subject REGEXP '^/m/|^/g/' AND object REGEXP '^/m/|^/g/' AND predicate NOT REGEXP '^/common/|^/key/|^/type/|^/kg/|^/base/|^/freebase/|^/dataworld/|^/topic_server/|^/user/|^/pipeline/|^/kp_lw/|^rdf|^owl'"

#removing reverse edges
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE INDEX idx_predicate ON freebase_clean(predicate)"
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE INDEX idx_object ON reverse_properties(object(126))"
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE freebase_clean_no_reverse SELECT f.subject, f.predicate, f.object from freebase_clean f LEFT OUTER JOIN reverse_properties r ON f.predicate=r.object WHERE r.object IS NULL"

#create list of mediator type labels
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE mediator_object_types_labels select t.label FROM mediator_object_types m JOIN types_id_label t ON m.subject=t.mid where m.object ='\"true\"'"

#create list of mediator nodes
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE INDEX idx_object ON object_types(object(150))"
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE object_types_clean SELECT * FROM object_types WHERE object NOT REGEXP '^/common/|^/key/|^/type/|^/kg/|^/base/|^/freebase/|^/dataworld/|^/topic_server/|^/user/|^/pipeline/|^/en/|^/kp_lw/|^rdf|^owl'"
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE INDEX idx_subject ON object_types_clean(subject)"
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE INDEX idx_object ON object_types_clean(object(150))"
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE INDEX idx_object ON mediator_object_types_labels(label(150))"
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE INDEX idx_subject ON object_names(subject)"
#identifying nodes in datagraph as mediator if at least one type the it belongs to is a mediator type and it does not have any label
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE mediator_entities SELECT DISTINCT t.subject AS entity FROM object_types t JOIN mediator_object_types_labels m ON t.object=m.label WHERE t.subject NOT IN (SELECT subject FROM object_names)"
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE INDEX idx_entity ON mediator_entities(entity)"

#freebase triples with mediator subject
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE freebase_clean_no_reverse_mediator_subject SELECT * FROM freebase_clean_no_reverse f WHERE f.subject IN (SELECT * FROM mediator_entities)" &

#freebase triples with mediator object
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE freebase_clean_no_reverse_mediator_object SELECT * FROM freebase_clean_no_reverse f WHERE f.object IN (SELECT * FROM mediator_entities)" &

wait

#find edges with both mediator-endpoints (these edges will be removed)
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE INDEX idx_spo ON freebase_clean_no_reverse_mediator_subject(subject, predicate, object(150))"
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE INDEX idx_spo ON freebase_clean_no_reverse_mediator_object(subject, predicate, object(150))"
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE double_mediator_edges SELECT s.subject, s.predicate, s.object FROM freebase_clean_no_reverse_mediator_subject s JOIN freebase_clean_no_reverse_mediator_object o WHERE s.subject=o.subject AND s.object=o.object AND s.predicate=o.predicate"

#removing triples having mediator nodes
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE freebase_clean_no_reverse_no_mediator SELECT * FROM freebase_clean_no_reverse WHERE subject NOT IN (SELECT * FROM mediator_entities) AND object NOT IN (SELECT * FROM mediator_entities)"

#removing double-mediator edges
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE INDEX idx_spo ON double_mediator_edges(subject, predicate, object(150))"
mysql -u $USERNAME -p$PASSWORD freebase -e "DELETE FROM freebase_clean_no_reverse_mediator_subject  WHERE EXISTS (SELECT * FROM double_mediator_edges WHERE subject=freebase_clean_no_reverse_mediator_subject.subject AND predicate=freebase_clean_no_reverse_mediator_subject.predicate AND object=freebase_clean_no_reverse_mediator_subject.object)"
mysql -u $USERNAME -p$PASSWORD freebase -e "DELETE FROM freebase_clean_no_reverse_mediator_object  WHERE EXISTS (SELECT * FROM double_mediator_edges WHERE subject=freebase_clean_no_reverse_mediator_object.subject AND predicate=freebase_clean_no_reverse_mediator_object.predicate AND object=freebase_clean_no_reverse_mediator_object.object)"

#create index for concatenating edges
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE INDEX idx_subject ON freebase_clean_no_reverse_mediator_subject(subject)" &
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE INDEX idx_object ON freebase_clean_no_reverse_mediator_object(object(150))" &
wait

#concatenating mediator-subject edges with mediator-subject edges
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE concatenate_edge_pairs_1 SELECT f1.object AS subject, CONCAT(f1.predicate, \"-\", f2.predicate) AS predicate, f2.object AS object  FROM freebase_clean_no_reverse_mediator_subject f1 JOIN freebase_clean_no_reverse_mediator_subject f2 ON f1.subject=f2.subject WHERE f1.predicate > f2.predicate" &

#concatenating mediator-object edges with mediator-object edges
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE concatenate_edge_pairs_2 SELECT f1.subject AS subject, CONCAT(f1.predicate, \"-\", f2.predicate) AS predicate, f2.subject AS object FROM freebase_clean_no_reverse_mediator_object f1 JOIN freebase_clean_no_reverse_mediator_object f2 ON f1.object=f2.object WHERE f1.predicate > f2.predicate" &

#concatenating mediator-subject edges with mediator-object edges
(mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE concatenate_edge_pairs_3_temp SELECT f2.subject AS subject, f2.predicate AS predicate1, f1.predicate AS predicate2, f1.object AS object FROM freebase_clean_no_reverse_mediator_subject f1 JOIN freebase_clean_no_reverse_mediator_object f2 ON f1.subject=f2.object WHERE f1.predicate != f2.predicate" &&
mysql -u $USERNAME -p$PASSWORD freebase -e "UPDATE concatenate_edge_pairs_3_temp c SET c.subject = (@temp_s:=c.subject), c.predicate1 = (@temp_p:=c.predicate1), c.subject = c.object, c.predicate1 = c.predicate2, c.object = @temp_s, c.predicate2 = @temp_p WHERE c.predicate1 < c.predicate2" &&
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE concatenate_edge_pairs_3 SELECT subject, CONCAT(predicate1, \"-\", predicate2) AS predicate, object FROM concatenate_edge_pairs_3_temp" &&
mysql -u $USERNAME -p$PASSWORD freebase -e "DROP TABLE concatenate_edge_pairs_3_temp") &

wait

#union of all concatenated edges
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE concatenate_edge_pairs LIKE concatenate_edge_pairs_1"
mysql -u $USERNAME -p$PASSWORD freebase -e "INSERT INTO concatenate_edge_pairs SELECT * FROM concatenate_edge_pairs_1"
mysql -u $USERNAME -p$PASSWORD freebase -e "INSERT INTO concatenate_edge_pairs SELECT * FROM concatenate_edge_pairs_2"
mysql -u $USERNAME -p$PASSWORD freebase -e "INSERT INTO concatenate_edge_pairs SELECT * FROM concatenate_edge_pairs_3"


#create datagraph
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE freebase_clean_no_reverse_no_mediator_new LIKE freebase_clean_no_reverse_no_mediator"
mysql -u $USERNAME -p$PASSWORD freebase -e "INSERT INTO freebase_clean_no_reverse_no_mediator_new SELECT * FROM freebase_clean_no_reverse_no_mediator"
mysql -u $USERNAME -p$PASSWORD freebase -e "INSERT INTO freebase_clean_no_reverse_no_mediator_new SELECT * FROM concatenate_edge_pairs"
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE INDEX idx_predicate ON freebase_clean_no_reverse_no_mediator_new(predicate)"
mysql -u $USERNAME -p$PASSWORD freebase -e "INSERT INTO properties_id_label(label) SELECT DISTINCT predicate FROM concatenate_edge_pairs"
mysql -u $USERNAME -p$PASSWORD freebase -e "SET @max_id = (SELECT MAX(id) FROM entities_id_label); SET @sql = CONCAT('ALTER TABLE properties_id_label AUTO_INCREMENT = ', @max_id + 1); PREPARE st FROM @sql; EXECUTE st"
mysql -u $USERNAME -p$PASSWORD freebase -e "ALTER TABLE properties_id_label ADD id INT AUTO_INCREMENT PRIMARY KEY"
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE INDEX idx_mid ON entities_id_label(mid)" &
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE INDEX idx_predicate ON properties_id_label(label(150))" &
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE INDEX idx_all ON freebase_clean_no_reverse_no_mediator_new(subject, predicate, object(150))" &
wait
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE freebase_datagraph SELECT DISTINCT e1.id AS subject, p.id AS predicate, e2.id AS object FROM freebase_clean_no_reverse_no_mediator_new f JOIN properties_id_label p JOIN entities_id_label e1 JOIN entities_id_label e2 WHERE (f.subject=e1.mid AND f.object=e2.mid AND f.predicate=p.label)"

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


