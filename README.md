
# Variants of Freebase for Robust Development of Intelligent Tasks on Knowledge Graphs

## Overview

This repository contains the dataset, preprocessing scripts, and experiment results to the paper [Creating Variants of Freebase for Robust Development of Intelligent Tasks on Knowledge Graphs](https://openreview.net/pdf?id=ikw7gqAGz7A), where we lay out a comprehensive analysis of the challenges and impacts associated with three idiosyncrasies(Mediator Nodes, Reverse Triples, and Metadata/Administrative Data) of Freebase, a large-scale, open-domain knowledge graph, on intelligent tasks such as link prediction, graph query system, and graph-to-text generation. 

## Dataset

Four clean variants of Freebase dataset are provided by inclusion/exclusion of various data modeling idiosyncrasies, which encables researchers to leverage or avoid such features based on the nature of their tasks. **The dataset can be downloaded from this [link](https://www.dropbox.com/s/idzqsh1a34swaz0/Freebases.zip?dl=0).**

The dataset consists of the four variants of Freebase dataset as well as related mapping/support files. For each variant, we made three kinds of files available:
- Subject matter triples file: fbx, where x ∈ 1, 2, 3, 4 (one file for each variant). 
- Metadata files: 
  - object_types: Each row maps the MID of a Freebase object to a type it belongs to. 
  - object_names: Each row maps the MID of a Freebase object to its textual label.
  - object_ids: Each row maps the MID of a Freebase object to its user-friendly identifier.
  - domains_id_label: Each row maps the MID of a Freebase domain to its label.
  - types_id_label: Each row maps the MID of a Freebase type to its label.
  - entities_id_label: Each row maps the MID of a Freebase entity to its label.
  - properties_id_label: Each row maps the MID of a Freebase property to its label.
  - uri_original2simplified and uri_simplified2original: The mapping between original URI and simplified URI and the mapping between simplified URI and original URI repectively.
- Type system file:
  - freebase_endtypes: Each row maps an edge type to its required subject type and object type.





















## License
[Freebase Data Dumps](https://developers.google.com/freebase/data) are provided free of charge for any purpose. They are distributed, like Freebase itself, under the [Creative Commons Attribution (aka CC-BY)](http://creativecommons.org/licenses/by/2.5/) and use is subject to the [Terms of Service](https://developers.google.com/freebase/terms). The Freebase/Wikidata ID mappings are provided under CC0 and can be used without restrictions.

