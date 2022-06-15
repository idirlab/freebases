## Data Cleaning Scripts

parse_triples.sh script is used for URI simplification. 

FBDataDump.sh is a script that runs parse_triples.sh and creates different MySQL tables from Freebase data dump. For example, tables for domains, types, properties, and entities. 

After running FBDataDump.sh, you may want to run one of the four scripts provided for each variants. All these four scripts detach the subject matter triples form the metadata and administrative triples. In addition, all these scripts create a type system for the final dataset. 

If you need to remove all the reverse triples as well as all the CVT nodes, you can run FB1.sh. 
To keep the reverse triples but to remove the CVT nodes, you can run FB2.sh. 
To keep the CVT nodes but to remove the reverse triples, you can run FB3.sh.
To keep both CVT nodes and reverse triples, you can run script FB4.sh.
