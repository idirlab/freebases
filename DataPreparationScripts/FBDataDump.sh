#!/bin/bash

set -e

USERNAME=$1
PASSWORD=$2

#downloading raw data
wget http://commondatastorage.googleapis.com/freebase-public/rdf/freebase-rdf-latest.gz
gunzip freebase-rdf-latest.gz

#URI simplification
./parse_triples.sh freebase-rdf-latest

#load raw data into table
mysql -u $USERNAME -p$PASSWORD  -e "CREATE DATABASE freebase"
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE freebase(subject VARCHAR(255), predicate VARCHAR(255), object TEXT)"
mysql -u $USERNAME -p$PASSWORD freebase -e "LOAD DATA LOCAL INFILE 'freebase-rdf-latest_formatted' INTO TABLE freebase"
mysql -u $USERNAME -p$PASSWORD freebase -e "UPDATE freebase SET object=REPLACE(object, '.', '/') WHERE object NOT LIKE '\"%'"

#create tables for object names, object ids, object types, mediator types, reverse types
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE object_names SELECT * FROM freebase WHERE predicate = '/type/object/name'" &
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE object_types SELECT * FROM freebase WHERE predicate = '/type/object/type'" &
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE object_ids SELECT * FROM freebase WHERE predicate = '/type/object/id'" &
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE INDEX idx_subject ON object_ids(subject)"
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE mediator_object_types SELECT * FROM freebase WHERE predicate = '/freebase/type_hints/mediator'" &
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE reverse_properties SELECT * FROM freebase WHERE predicate = '/type/property/reverse_property'" &
wait

#extract domains
mysql -u $USERNAME -p$PASSWORD freebase -e "create table domains select * from object_types where object = '/type/domain'"
mysql -u $USERNAME -p$PASSWORD freebase -e "create index idx_subject ON domains(subject)"
mysql -u $USERNAME -p$PASSWORD freebase -e "create table domains_id_label select object_ids.subject AS mid, TRIM(BOTH '\"' FROM object_ids.object) AS label FROM domains join object_ids on domains.subject=object_ids.subject"
mysql -u $USERNAME -p$PASSWORD freebase -e "DELETE FROM domains_id_label WHERE label REGEXP '^/common/|^/key/|^/type/|^/kg/|^/base/|^/freebase/|^/dataworld/|^/topic_server/|^/user/|^/pipeline/|^/en/|^/kp_lw/|^rdf|^owl'"
mysql -u $USERNAME -p$PASSWORD freebase -e "UPDATE domains_id_label SET label = replace(label, '/', '')"
mysql -u $USERNAME -p$PASSWORD freebase -e "ALTER TABLE domains_id_label ADD id INT AUTO_INCREMENT PRIMARY KEY"
mysql -u $USERNAME -p$PASSWORD freebase -e "OPTIMIZE TABLE domains_id_label"

#extract types
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE types SELECT * FROM object_types WHERE object = '/type/type'"
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE INDEX idx_subject ON types(subject)"
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE types_id_label SELECT object_ids.subject AS mid, object_ids.object AS label FROM types join object_ids on types.subject=object_ids.subject"
mysql -u $USERNAME -p$PASSWORD freebase -e "UPDATE types_id_label SET label = TRIM(BOTH '\"' FROM label)"
mysql -u $USERNAME -p$PASSWORD freebase -e "DELETE FROM types_id_label WHERE label REGEXP '^/common/|^/key/|^/type/|^/kg/|^/base/|^/freebase/|^/dataworld/|^/topic_server/|^/user/|^/pipeline/|^/en/|^/kp_lw/|^rdf|^owl'"
mysql -u $USERNAME -p$PASSWORD freebase -e "SET @max_id = (SELECT MAX(id) FROM domains_id_label); SET @sql = CONCAT('ALTER TABLE types_id_label AUTO_INCREMENT = ', @max_id + 1); PREPARE st FROM @sql; EXECUTE st"
mysql -u $USERNAME -p$PASSWORD freebase -e "ALTER TABLE types_id_label ADD id INT AUTO_INCREMENT PRIMARY KEY"
mysql -u $USERNAME -p$PASSWORD freebase -e "OPTIMIZE TABLE types_id_label"

#extract properties
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE properties select * from object_types where object = '/type/property'"
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE INDEX idx_subject ON properties(subject)"
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE properties_id_label select object_ids.subject AS mid, object_ids.object AS label FROM properties JOIN object_ids ON properties.subject=object_ids.subject"
mysql -u $USERNAME -p$PASSWORD freebase -e "UPDATE properties_id_label SET label = TRIM(BOTH '\"' FROM label)"
mysql -u $USERNAME -p$PASSWORD freebase -e "DELETE FROM properties_id_label WHERE label REGEXP '^/common/|^/key/|^/type/|^/kg/|^/base/|^/freebase/|^/dataworld/|^/topic_server/|^/user/|^/pipeline/|^/en/|^/kp_lw/|^rdf|^owl'"
mysql -u $USERNAME -p$PASSWORD freebase -e "OPTIMIZE TABLE properties_id_label"

#extract entities
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE entities_id_label SELECT DISTINCT subject AS mid, TRIM(BOTH '\"' FROM TRIM(TRAILING '@en' FROM object)) AS label FROM object_names WHERE subject REGEXP '^/m/|^/g/' AND object LIKE ('%@en')"
mysql -u $USERNAME -p$PASSWORD freebase -e "SET @max_id = (SELECT MAX(id) FROM types_id_label); SET @sql = CONCAT('ALTER TABLE entities_id_label AUTO_INCREMENT = ', @max_id + 1); PREPARE st FROM @sql; EXECUTE st"
mysql -u $USERNAME -p$PASSWORD freebase -e "ALTER TABLE entities_id_label ADD id INT AUTO_INCREMENT PRIMARY KEY"
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE TABLE entities_id_label_clean SELECT mid, TRIM('\t' FROM TRIM(TRIM('\t' from TRIM(TRIM('\t' from REPLACE(CONVERT(label USING ASCII), '?', '')))))) AS label, id FROM entities_id_label"
mysql -u $USERNAME -p$PASSWORD freebase -e "DELETE FROM entities_id_label_clean WHERE length(label) = 0 OR length(label) != length(replace(label, '\n', ''))"
mysql -u $USERNAME -p$PASSWORD freebase -e "DELETE FROM entities_id_label_clean WHERE label NOT REGEXP '[A-Za-z0-9]'"
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE INDEX idx_id ON entities_id_label_clean(id)"
mysql -u $USERNAME -p$PASSWORD freebase -e "CREATE INDEX idx_label ON entities_id_label_clean(label(60))"
