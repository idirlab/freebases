## Datasets

We have provided four variants of Freebase dataset. The detailed statistics of these four variants are shown in the table below. 

![This is an image](https://github.com/idirlab/freebases/blob/main/Datasets/DatasetsStatistics.png?raw=true)

If you need to remove all the reverse triples as well as all the CVT nodes, you can use FB1 dataset.

To keep the reverse triples but to remove the CVT nodes, you can use FB2 dataset.

To keep the CVT nodes but to remove the reverse triples, you can use FB3 dataset.

To keep both CVT nodes and reverse triples, you can use FB4 dataset.

For each dataset, we made three kinds of files available:
- Metadata files: object_types, object_ids, object_names, domains_id_label, types_id_label, entities_id_label, and properties_id_label
- Subject matter triples file: fbx, where x ∈ 1, 2, 3, 4
- Type system file: freebase_endtypes
