
# Variants of Freebase for Robust Development of Intelligent Tasks on Knowledge Graphs

## Overview

This repository contains the dataset, preprocessing scripts, and experiment results to the paper [Creating Variants of Freebase for Robust Development of Intelligent Tasks on Knowledge Graphs](https://openreview.net/pdf?id=ikw7gqAGz7A), where we lay out a comprehensive analysis of the challenges and impacts associated with three idiosyncrasies(Mediator Nodes, Reverse Triples, and Metadata/Administrative Data) of Freebase, a large-scale, open-domain knowledge graph, on intelligent tasks such as link prediction, graph query system, and graph-to-text generation. 

## Dataset

Four clean variants of Freebase dataset are provided by inclusion/exclusion of various data modeling idiosyncrasies, which encables researchers to leverage or avoid such features based on the nature of their tasks. **The dataset can be downloaded from this [link](https://www.dropbox.com/s/idzqsh1a34swaz0/Freebases.zip?dl=0).**

### Dataset Statistics

<table>
    <tr>
        <td>variant</td>
        <td>CVT nodes</td>
        <td>reverse triples</td>
        <td>#entities</td>
        <td>#properties</td>
        <td>#triples</td>
    </tr>
    <tr>
        <td>FB1</td>
        <td>removed</td>
        <td>removed</td>
        <td>39,732,008</td>
        <td>2,891</td>
        <td>103,324,039</td>
    </tr>
    <tr>
        <td>FB2</td>
        <td>removed</td>
        <td>retained</td>
        <td>39,745,618</td>
        <td>4,894</td>
        <td>235,307,422</td>
    </tr>
    <tr>
        <td>FB3</td>
        <td>retained</td>
        <td>removed</td>
        <td>59,894,890</td>
        <td>2,641</td>
        <td>134,213,735</td>
    </tr>
    <tr>
        <td>FB4</td>
        <td>retained</td>
        <td>retained</td>
        <td>59,896,902</td>
        <td>4,425</td>
        <td>244,112,599</td>
    </tr>
</table>

### Dataset Details
The dataset consists of the four variants of Freebase dataset as well as related mapping/support files. For each variant, we made three kinds of files available:
- Subject matter triples file: fbx, where x ∈ 1, 2, 3, 4 (one file for each variant). Subject matter triples are the triples belong to subject matters domains—domains describing real-world facts.
  - Example
    - >/g/112yfy2xr, /music/album/release_type, /m/02lx2r
  - Explaination
    - "/g/112yfy2xr" and "/m/02lx2r" are the MID of the subject entity and object entity, respectively. "/music/album/release_type" is the realtionship between the two entities. 
- Type system file:
  - freebase_endtypes: Each row maps an edge type to its required subject type and object type.
    - Example
      - > 92, 47178872, 90 
    - Explanation
      - "92" and "90" are the type id of the subject and object which has the relationship id "47178872".
- Metadata files: 
  - object_types: Each row maps the MID of a Freebase object to a type it belongs to. 
    - Example
      - >/g/11b41c22g, /type/object/type, /people/person
    - Explanation
      - The entity with MID "/g/11b41c22g" has a type "/people/person"
  - object_names: Each row maps the MID of a Freebase object to its textual label.
    - Example
      - >/g/11b78qtr5m, /type/object/name, "Viroliano Tries Jazz"@en
    - Explanation
      - The entity with MID "/g/11b78qtr5m" has name "Viroliano Tries Jazz" in English.
  - object_ids: Each row maps the MID of a Freebase object to its user-friendly identifier.
    - Example
      - >/m/05v3y9r, /type/object/id, "/music/live_album/concert"
    - Explanation
      - The entity with MID "/m/05v3y9r" can be interpreted by human as a music concert live album.
  - domains_id_label: Each row maps the MID of a Freebase domain to its label.
    - Example
      - >/m/05v4pmy, geology, 77
    - Explanation
      - The object with MID "/m/05v4pmy" in Freebase is the domain "geology", and has id "77" in our dataset.
  - types_id_label: Each row maps the MID of a Freebase type to its label.
    - Example
      - >/m/01xljxh, /government/political_party, 147
    - Explanation
      - The object with MID "/m/01xljxh" in Freebase is the type "/government/political_party", and has id "147" in our dataset.
  - entities_id_label: Each row maps the MID of a Freebase entity to its label.
    - Example
      - >/g/11b78qtr5m, Viroliano Tries Jazz, 2234
    - Explanation
      - The entity with MID "/g/11b78qtr5m" in Freebase is "Viroliano Tries Jazz", and has id "2234" in our dataset.
  - properties_id_label: Each row maps the MID of a Freebase property to its label.
    - Example
      - >/m/010h8tp2, /comedy/comedy_group/members, 47178867
    - Explanation
      - The object with MID "/m/010h8tp2" in Freebase is a property(relation/edge), it has label "/comedy/comedy_group/members" and has id "47178867" in our dataset.
  - uri_original2simplified and uri_simplified2original: The mapping between original URI and simplified URI and the mapping between simplified URI and original URI repectively.
    - Example
      - uri_original2simplified >"<http://rdf.freebase.com/ns/type.property.unique>": "/type/property/unique"
      - uri_simplified2original >"/type/property/unique": "<http://rdf.freebase.com/ns/type.property.unique>"
    - Explanation
      - The URI "<http://rdf.freebase.com/ns/type.property.unique>" in the original Freebase RDF dataset is simplified into "/type/property/unique" in our dataset. 
      - The identifier "/type/property/unique" in our dataset has URI <http://rdf.freebase.com/ns/type.property.unique> in the original Freebase RDF dataset.


## Experiments

We conducted all the link prediction experiments on four datasets using DGL-KE framework ([Zheng et al.,2020](https://arxiv.org/pdf/2004.08532.pdf)). 

The hyperparameters used for each experiment, its training/test time, and more details can be found in the script provided for each dataset 

In the tables below, an upward/downward arrow beside a measure indicates that methods with greater/smaller values by that measure possess higher accuracy.

The results of these experiments on FB1, FB2, FB3, and FB4 dataset are shown in the table below. 



















## License
[Freebase Data Dumps](https://developers.google.com/freebase/data) are provided free of charge for any purpose. They are distributed, like Freebase itself, under the [Creative Commons Attribution (aka CC-BY)](http://creativecommons.org/licenses/by/2.5/) and use is subject to the [Terms of Service](https://developers.google.com/freebase/terms). The Freebase/Wikidata ID mappings are provided under CC0 and can be used without restrictions.

