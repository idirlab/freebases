## Datasets

We have provided four variants of Freebase dataset. **These datasets can be downloaded from this [link](https://www.dropbox.com/s/6dfwropwpllhnff/fbVar.zip?dl=0).**

The detailed statistics of these four variants are shown in the table below. 

![This is an image](https://github.com/idirlab/freebases/blob/main/Datasets/DatasetsStatistics.png?raw=true)

If you need to remove all the reverse triples as well as all the CVT nodes, you can use FB1 dataset.

To keep the reverse triples but to remove the CVT nodes, you can use FB2 dataset.

To keep the CVT nodes but to remove the reverse triples, you can use FB3 dataset.

To keep both CVT nodes and reverse triples, you can use FB4 dataset.

For each dataset, we made three kinds of files available:
- Metadata files: 
  - object_types: Each row maps the MID of a Freebase object to a type it belongs. 
  - object_names: Each row maps the MID of a Freebase object to its textual label.
  - object_ids: Each row maps the MID of a Freebase object to its friendly identifier.
  - domains_id_label: Each row maps the MID of a Freebase domain to its label.
  - types_id_label: Each row maps the MID of a Freebase type to its label.
  - entities_id_label: Each row maps the MID of a Freebase entity to its label.
  - properties_id_label: Each row maps the MID of a Freebase property to its label.
- Subject matter triples file: fbx, where x ∈ 1, 2, 3, 4 (one file for each variant)
- Type system file:
  - freebase_endtypes: Each row maps an edge type to its required subject type and object type.
