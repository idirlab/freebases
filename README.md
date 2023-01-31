
# Comprehensive Analysis of Freebase and Creation of Datasets for Robust Evaluation of Knowledge Graph Completion Methods

## Overview

This repository contains the dataset, preprocessing scripts, and experiment results to the paper [Comprehensive Analysis of Freebase and Creation of Datasets for Robust Evaluation of Knowledge Graph Completion Methods](https://openreview.net/pdf?id=ikw7gqAGz7A), where we lay out a comprehensive analysis of the challenges and impacts associated with three idiosyncrasies(Reverse Triples, Mediator Nodes, and Type System) of Freebase, a large-scale, open-domain knowledge graph on Knowledge Graph Completion tasks such as link prediction. 

Freebase is amongst the largest public cross-domain KGs that store common facts. It possesses several data modeling idiosyncrasies rarely found in comparable datasets such as Wikidata, YAGO, and so on. Though closed in 2015, Freebase still serves as an important knowledge graph in intelligent tasks. We checked all full-length papers that use datasets commonly used for link prediction and were published in 12 top conferences during their latest versions, in 2022. The 12 conferences are AAAL, IJCAI, WWW, KDD, ICML, ACL, EMNLP, NAACL, SIGIR, NeurIPS, SIGMOD, and VLDB. That amounts to 53 papers. 48 out of the 53 papers used datasets produced from Freebase, while only 8 used datasets from Wikidata. The papers and the datasets used in the papers are listed in file **papers.xlsx**. 

**Reverse Triples**

When a new fact was included into Freebase, it would be added as a pair of reverse triples. For instance, *(A Room With A View,167
/film/film/directed_by, James Ivory)* and *(James Ivory, film/director/film, A Room With A View)* form a pair of reverse triples. They have the same semantic meaning.

**Mediator Nodes**

Mediator nodes, also called CVT nodes, are used in Freebase to represent n-ary relationships. The figure below shows a CVT node connected to an award, a nominee, and a work. This or similar approach is necessary for accurate modeling of the real-world.

![image](https://user-images.githubusercontent.com/44850160/187091882-0164271e-423e-4098-9af6-2105dd95f4f5.png)

**Type System**

Freebase categorizes each topic into one or more types and each type into one domain. Furthermore, the triple instances satisfy pseudo constraints as if they are governed by a rigorous type system. Specifically, 1) given a node, its types set up constraints on the labels of its properties; the type segment in the label of an edge (which is different from the edge type) in most cases belongs to one of the types of the subject node. 2) Given an edge type and its edge instances, there is almost a function that maps from the edge type to a type that all subjects in the edge instances belong to, and similarly almost such a function for objects. 

## Dataset

Four variants of Freebase dataset are provided by inclusion/exclusion of various data modeling idiosyncrasies, which encables researchers to leverage or avoid such features based on the nature of their tasks. **The dataset can be downloaded from this [link](https://www.dropbox.com/s/idzqsh1a34swaz0/Freebases.zip?dl=0).**

### Dataset Statistics

<table class="tg">
<thead>
  <tr>
    <th class="tg-fymr">variant</th>
    <th class="tg-7btt">CVT nodes</th>
    <th class="tg-7btt">reverse triples</th>
    <th class="tg-7btt">#entities</th>
    <th class="tg-7btt">#properties</th>
    <th class="tg-7btt">#triples</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td class="tg-0pky">FB-CVT-REV</td>
    <td class="tg-c3ow">removed</td>
    <td class="tg-c3ow">removed</td>
    <td class="tg-c3ow">46,069,321</td>
    <td class="tg-c3ow">3,055</td>
    <td class="tg-c3ow">125,124,274</td>
  </tr>
  <tr>
    <td class="tg-0pky">FB-CVT+REV</td>
    <td class="tg-c3ow">removed</td>
    <td class="tg-c3ow">retained</td>
    <td class="tg-c3ow">46,077,533</td>
    <td class="tg-c3ow">5,028</td>
    <td class="tg-c3ow">238,981,274</td>
  </tr>
  <tr>
    <td class="tg-0pky">FB+CVT-REV</td>
    <td class="tg-c3ow">retained</td>
    <td class="tg-c3ow">removed</td>
    <td class="tg-c3ow">59,894,890</td>
    <td class="tg-c3ow">2,641</td>
    <td class="tg-c3ow">134,213,735</td>
  </tr>
  <tr>
    <td class="tg-0pky">FB+CVT+REV</td>
    <td class="tg-c3ow">retained</td>
    <td class="tg-c3ow">retained</td>
    <td class="tg-c3ow">59,896,902</td>
    <td class="tg-c3ow">4,425</td>
    <td class="tg-c3ow">244,112,599</td>
  </tr>
</tbody>
</table>

### Dataset Details
The dataset consists of the four variants of Freebase dataset as well as related mapping/support files. For each variant, we made three kinds of files available:
- **Subject matter triples file**
  - *fb+/-CVT+/-REV* 
    One folder for each variant. In each folder there are 5 files: train.txt, valid.txt, test.txt, entity2id.txt, relation2id.txt
    Subject matter triples are the triples belong to subject matters domains—domains describing real-world facts.
    - Example of a row in train.txt, valid.txt, and test.txt
      - > 2, 192, 0 
    - Example of a row in entity2id.txt: 
      - /g/112yfy2xr, 2 
    - Example of a row in relation2id.txt: 
      - /music/album/release_type, 192 
    - Explaination
      - "/g/112yfy2xr" and "/m/02lx2r" are the MID of the subject entity and object entity, respectively. "/music/album/release_type" is the realtionship between the two entities. 2, 192, and 0 are the IDs assigned by the authors to the objects. 
- **Type system file**
  - *freebase_endtypes*: Each row maps an edge type to its required subject type and object type.
    - Example
      - > 92, 47178872, 90 
    - Explanation
      - "92" and "90" are the type id of the subject and object which has the relationship id "47178872".
- **Metadata files**
  - *object_types*: Each row maps the MID of a Freebase object to a type it belongs to. 
    - Example
      - >/g/11b41c22g, /type/object/type, /people/person
    - Explanation
      - The entity with MID "/g/11b41c22g" has a type "/people/person"
  - *object_names*: Each row maps the MID of a Freebase object to its textual label.
    - Example
      - >/g/11b78qtr5m, /type/object/name, "Viroliano Tries Jazz"@en
    - Explanation
      - The entity with MID "/g/11b78qtr5m" has name "Viroliano Tries Jazz" in English.
  - *object_ids*: Each row maps the MID of a Freebase object to its user-friendly identifier.
    - Example
      - >/m/05v3y9r, /type/object/id, "/music/live_album/concert"
    - Explanation
      - The entity with MID "/m/05v3y9r" can be interpreted by human as a music concert live album.
  - *domains_id_label*: Each row maps the MID of a Freebase domain to its label.
    - Example
      - >/m/05v4pmy, geology, 77
    - Explanation
      - The object with MID "/m/05v4pmy" in Freebase is the domain "geology", and has id "77" in our dataset.
  - *types_id_label*: Each row maps the MID of a Freebase type to its label.
    - Example
      - >/m/01xljxh, /government/political_party, 147
    - Explanation
      - The object with MID "/m/01xljxh" in Freebase is the type "/government/political_party", and has id "147" in our dataset.
  - *entities_id_label*: Each row maps the MID of a Freebase entity to its label.
    - Example
      - >/g/11b78qtr5m, Viroliano Tries Jazz, 2234
    - Explanation
      - The entity with MID "/g/11b78qtr5m" in Freebase is "Viroliano Tries Jazz", and has id "2234" in our dataset.
  - *properties_id_label*: Each row maps the MID of a Freebase property to its label.
    - Example
      - >/m/010h8tp2, /comedy/comedy_group/members, 47178867
    - Explanation
      - The object with MID "/m/010h8tp2" in Freebase is a property(relation/edge), it has label "/comedy/comedy_group/members" and has id "47178867" in our dataset.
  - *uri_original2simplified* and *uri_simplified2original*: The mapping between original URI and simplified URI and the mapping between simplified URI and original URI repectively.
    - Example
      - *uri_original2simplified*
        - >"<http://rdf.freebase.com/ns/type.property.unique>": "/type/property/unique" 
        
        (the URI directs to nothing because Freebase has been closed)
      - *uri_simplified2original*
        - >"/type/property/unique": "<http://rdf.freebase.com/ns/type.property.unique>" 
        
        (the URI directs to nothing because Freebase has been closed)
    - Explanation
      - The URI "<http://rdf.freebase.com/ns/type.property.unique>" in the original Freebase RDF dataset is simplified into "/type/property/unique" in our dataset. 
      - The identifier "/type/property/unique" in our dataset has URI <http://rdf.freebase.com/ns/type.property.unique> in the original Freebase RDF dataset.


## Experiments & Results

We conducted all the link prediction experiments on four datasets using DGL-KE framework ([Zheng et al.,2020](https://arxiv.org/pdf/2004.08532.pdf)). 

The hyperparameters used for each experiment, its training/test time, and more details can be found in the script provided for each dataset. 

The results of these experiments on our datasets are shown in the table below. 
<table class="tg">
<thead>
  <tr>
    <th class="tg-0pky"></th>
    <th class="tg-c3ow" colspan="4">FB1</th>
    <th class="tg-c3ow" colspan="4">FB2</th>
    <th class="tg-c3ow" colspan="4">FB3</th>
    <th class="tg-c3ow" colspan="4">FB4</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td class="tg-0pky">Model</td>
    <td class="tg-c3ow">MRR</td>
    <td class="tg-c3ow">MR</td>
    <td class="tg-c3ow">H1</td>
    <td class="tg-c3ow">H10</td>
    <td class="tg-0pky">MRR</td>
    <td class="tg-0pky">MR</td>
    <td class="tg-0pky">H1</td>
    <td class="tg-0pky">H10</td>
    <td class="tg-0pky">MRR</td>
    <td class="tg-0pky">MR</td>
    <td class="tg-0pky">H1</td>
    <td class="tg-0pky">H10</td>
    <td class="tg-0pky">MRR</td>
    <td class="tg-0pky">MR</td>
    <td class="tg-0pky">H1</td>
    <td class="tg-0pky">H10</td>
  </tr>
  <tr>
    <td class="tg-0pky">TransE</td>
    <td class="tg-c3ow">0.686</td>
    <td class="tg-c3ow">41.810</td>
    <td class="tg-c3ow">0.625</td>
    <td class="tg-c3ow">0.799</td>
    <td class="tg-0pky">0.958</td>
    <td class="tg-0pky">3.857</td>
    <td class="tg-0pky">0.944</td>
    <td class="tg-0pky">0.980</td>
    <td class="tg-0pky">0.431</td>
    <td class="tg-0pky">50.572</td>
    <td class="tg-0pky">0.339</td>
    <td class="tg-0pky">0.623</td>
    <td class="tg-0pky">0.606</td>
    <td class="tg-0pky">12.542</td>
    <td class="tg-0pky">0.515</td>
    <td class="tg-0pky">0.771</td>
  </tr>
  <tr>
    <td class="tg-0pky">DistMult</td>
    <td class="tg-c3ow">0.709</td>
    <td class="tg-c3ow">69.388</td>
    <td class="tg-c3ow">0.670</td>
    <td class="tg-c3ow">0.780</td>
    <td class="tg-0pky">0.965</td>
    <td class="tg-0pky">6.059</td>
    <td class="tg-0pky">0.956</td>
    <td class="tg-0pky">0.979</td>
    <td class="tg-0pky">0.408</td>
    <td class="tg-0pky">109.193</td>
    <td class="tg-0pky">0.318</td>
    <td class="tg-0pky">0.581</td>
    <td class="tg-0pky">0.818</td>
    <td class="tg-0pky">19.180</td>
    <td class="tg-0pky">0.777</td>
    <td class="tg-0pky">0.890</td>
  </tr>
  <tr>
    <td class="tg-0pky">ComplEx</td>
    <td class="tg-c3ow">0.717</td>
    <td class="tg-c3ow">68.798</td>
    <td class="tg-c3ow">0.681</td>
    <td class="tg-c3ow">0.783</td>
    <td class="tg-0pky">0.970</td>
    <td class="tg-0pky">5.567</td>
    <td class="tg-0pky">0.964</td>
    <td class="tg-0pky">0.981</td>
    <td class="tg-0pky">0.510</td>
    <td class="tg-0pky">104.317</td>
    <td class="tg-0pky">0.439</td>
    <td class="tg-0pky">0.635</td>
    <td class="tg-0pky">0.899</td>
    <td class="tg-0pky">16.937</td>
    <td class="tg-0pky">0.880</td>
    <td class="tg-0pky">0.935</td>
  </tr>
  <tr>
    <td class="tg-0pky">RotatE</td>
    <td class="tg-c3ow">0.455</td>
    <td class="tg-c3ow">143.688</td>
    <td class="tg-c3ow">0.399</td>
    <td class="tg-c3ow">0.559</td>
    <td class="tg-0pky">0.938</td>
    <td class="tg-0pky">13.513</td>
    <td class="tg-0pky">0.926</td>
    <td class="tg-0pky">0.956</td>
    <td class="tg-0pky">0.198</td>
    <td class="tg-0pky">195.001</td>
    <td class="tg-0pky">0.147</td>
    <td class="tg-0pky">0.292</td>
    <td class="tg-0pky">0.729</td>
    <td class="tg-0pky">33.027</td>
    <td class="tg-0pky">0.683</td>
    <td class="tg-0pky">0.816</td>
  </tr>
</tbody>
</table>


Another way of evaluation embedding models is to find their performance on triple classification. This task is the binary classification of triples regarding whether they are true or false facts. The results of our triple classification task are shown in the tables below.

<table class="tg">
<thead>
  <tr>
    <th class="tg-c3ow"></th>
    <th class="tg-7btt" colspan="4">consistent h</th>
    <th class="tg-7btt" colspan="4">inconsistent h</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td class="tg-c3ow">Model</td>
    <td class="tg-c3ow">Precision</td>
    <td class="tg-c3ow">Recall</td>
    <td class="tg-c3ow">Acc</td>
    <td class="tg-c3ow">F1</td>
    <td class="tg-c3ow">Precision</td>
    <td class="tg-c3ow">Recall</td>
    <td class="tg-c3ow">Acc</td>
    <td class="tg-c3ow">F1</td>
  </tr>
  <tr>
    <td class="tg-7btt">RESCAL</td>
    <td class="tg-c3ow">0.59</td>
    <td class="tg-c3ow">0.37</td>
    <td class="tg-c3ow">0.55</td>
    <td class="tg-c3ow">0.45</td>
    <td class="tg-c3ow">0.95</td>
    <td class="tg-c3ow">0.83</td>
    <td class="tg-c3ow">0.89</td>
    <td class="tg-c3ow">0.89</td>
  </tr>
  <tr>
    <td class="tg-7btt">TransE</td>
    <td class="tg-c3ow">0.52</td>
    <td class="tg-c3ow">0.59</td>
    <td class="tg-c3ow">0.52</td>
    <td class="tg-c3ow">0.55</td>
    <td class="tg-c3ow">0.81</td>
    <td class="tg-c3ow">0.69</td>
    <td class="tg-c3ow">0.76</td>
    <td class="tg-c3ow">0.74</td>
  </tr>
  <tr>
    <td class="tg-7btt">DistMult</td>
    <td class="tg-c3ow">0.53</td>
    <td class="tg-c3ow">0.51</td>
    <td class="tg-c3ow">0.53</td>
    <td class="tg-c3ow">0.52</td>
    <td class="tg-c3ow">0.94</td>
    <td class="tg-c3ow">0.87</td>
    <td class="tg-c3ow">0.91</td>
    <td class="tg-c3ow">0.90</td>
  </tr>
  <tr>
    <td class="tg-7btt">ComplEx</td>
    <td class="tg-c3ow">0.54</td>
    <td class="tg-c3ow">0.48</td>
    <td class="tg-c3ow">0.53</td>
    <td class="tg-c3ow">0.51</td>
    <td class="tg-c3ow">0.94</td>
    <td class="tg-c3ow">0.88</td>
    <td class="tg-c3ow">0.91</td>
    <td class="tg-c3ow">0.91</td>
  </tr>
  <tr>
    <td class="tg-7btt">ConvE</td>
    <td class="tg-c3ow">0.54</td>
    <td class="tg-c3ow">0.53</td>
    <td class="tg-c3ow">0.54</td>
    <td class="tg-c3ow">0.53</td>
    <td class="tg-c3ow">0.57</td>
    <td class="tg-c3ow">0.72</td>
    <td class="tg-c3ow">0.59</td>
    <td class="tg-c3ow">0.64</td>
  </tr>
  <tr>
    <td class="tg-7btt">RotatE</td>
    <td class="tg-c3ow">0.52</td>
    <td class="tg-c3ow">0.53</td>
    <td class="tg-c3ow">0.52</td>
    <td class="tg-c3ow">0.52</td>
    <td class="tg-c3ow">0.89</td>
    <td class="tg-c3ow">0.83</td>
    <td class="tg-c3ow">0.87</td>
    <td class="tg-c3ow">0.86</td>
  </tr>
<thead>
  <tr>
    <th class="tg-c3ow"></th>
    <th class="tg-7btt" colspan="4">consistent t</th>
    <th class="tg-7btt" colspan="4">inconsistent t</th>
  </tr>
</thead>
  <tr>
    <td class="tg-c3ow">Model</td>
    <td class="tg-c3ow">Precision</td>
    <td class="tg-c3ow">Recall</td>
    <td class="tg-c3ow">Acc</td>
    <td class="tg-c3ow">F1</td>
    <td class="tg-c3ow">Precision</td>
    <td class="tg-c3ow">Recall</td>
    <td class="tg-c3ow">Acc</td>
    <td class="tg-c3ow">F1</td>
  </tr>
  <tr>
    <td class="tg-7btt">RESCAL</td>
    <td class="tg-c3ow">0.64</td>
    <td class="tg-c3ow">0.45</td>
    <td class="tg-c3ow">0.60</td>
    <td class="tg-c3ow">0.53</td>
    <td class="tg-c3ow">0.95</td>
    <td class="tg-c3ow">0.86</td>
    <td class="tg-c3ow">0.91</td>
    <td class="tg-c3ow">0.90</td>
  </tr>
  <tr>
    <td class="tg-7btt">TransE</td>
    <td class="tg-c3ow">0.58</td>
    <td class="tg-c3ow">0.54</td>
    <td class="tg-c3ow">0.57</td>
    <td class="tg-c3ow">0.56</td>
    <td class="tg-c3ow">0.90</td>
    <td class="tg-c3ow">0.82</td>
    <td class="tg-c3ow">0.86</td>
    <td class="tg-c3ow">0.86</td>
  </tr>
  <tr>
    <td class="tg-7btt">DistMult</td>
    <td class="tg-c3ow">0.59</td>
    <td class="tg-c3ow">0.55</td>
    <td class="tg-c3ow">0.58</td>
    <td class="tg-c3ow">0.57</td>
    <td class="tg-c3ow">0.95</td>
    <td class="tg-c3ow">0.89</td>
    <td class="tg-c3ow">0.92</td>
    <td class="tg-c3ow">0.92</td>
  </tr>
  <tr>
    <td class="tg-7btt">ComplEx</td>
    <td class="tg-c3ow">0.60</td>
    <td class="tg-c3ow">0.56</td>
    <td class="tg-c3ow">0.59</td>
    <td class="tg-c3ow">0.58</td>
    <td class="tg-c3ow">0.95</td>
    <td class="tg-c3ow">0.90</td>
    <td class="tg-c3ow">0.93</td>
    <td class="tg-c3ow">0.92</td>
  </tr>
  <tr>
    <td class="tg-7btt">ConvE</td>
    <td class="tg-c3ow">0.62</td>
    <td class="tg-c3ow">0.41</td>
    <td class="tg-c3ow">0.58</td>
    <td class="tg-c3ow">0.49</td>
    <td class="tg-c3ow">0.95</td>
    <td class="tg-c3ow">0.83</td>
    <td class="tg-c3ow">0.89</td>
    <td class="tg-c3ow">0.88</td>
  </tr>
  <tr>
    <td class="tg-7btt">RotatE</td>
    <td class="tg-c3ow">0.60</td>
    <td class="tg-c3ow">0.47</td>
    <td class="tg-c3ow">0.58</td>
    <td class="tg-c3ow">0.53</td>
    <td class="tg-c3ow">0.87</td>
    <td class="tg-c3ow">0.78</td>
    <td class="tg-c3ow">0.83</td>
    <td class="tg-c3ow">0.82</td>
  </tr>
</tbody>
</table>

The experiments on triple classification were done using LibKGE framework. ([Broscheit et al.,2020](https://aclanthology.org/2020.emnlp-demos.22.pdf))

## Scripts

### Data Preparation Scripts

- **parse_triples.sh** script is used for URI simplification.

- **FBDataDump.sh** is a script that runs parse_triples.sh and creates different MySQL tables from Freebase data dump. For example, tables for domains, types, properties, and entities. 
    Command to run FBDataDump.sh:
   
  ``
  ./FBDataDump.sh mysql_username mysql_password
  ``

    After running FBDataDump.sh, you may want to run one of the four scripts provided for each variants. All these four scripts detach the subject matter triples from  the metadata and administrative triples. In addition, all these scripts create a type system for the final dataset. Command to run **FBx.sh**, where x ∈ {1,2,3,4}:

  ``
  ./FBx.sh mysql_username mysql_password
  ``
- If you need to remove all the reverse triples as well as all the CVT nodes, you can run **FB1.sh**.

- To keep the reverse triples but to remove the CVT nodes, you can run **FB2.sh**.

- To keep the CVT nodes but to remove the reverse triples, you can run **FB3.sh**.

- To keep both CVT nodes and reverse triples, you can run script **FB4.sh**.


### Experiments Scripts

We did expeiments on the four variants of Freebase as well as FB15K and FB-15K-237 using link prediction models like TransE, DistMult, ComplEx, RotatE, etc. The scripts to run the experiments are at ExperimentsScripts/ ending with .sh. An example of running DistMult model on FB1 is as below.

``
dglke_train --model_name DistMult --dataset Freebase --data_path ./data --format udd_hrt  \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt  --batch_size 1024 --neg_sample_size 256 --hidden_dim 400 --gamma 143.0 \
--lr 0.08 --batch_size_eval 1000 --test -adv --mix_cpu_gpu --num_proc 8 --gpu 0 1 --max_step 300000 --neg_sample_size_eval 1000 \
--eval_interval 100000 --log_interval 1000 --async_update --rel_part --force_sync_interval 10000 --num_thread 4 --no_save_emb --delimiter ,
``

## License

The dataset and code is made available under the [CC0 1.0 Universal](https://github.com/idirlab/freebases/blob/main/LICENSE).

Note: [Freebase Data Dumps](https://developers.google.com/freebase) is provided free of charge for any purpose. It is distributed under the [Creative Commons Attribution (aka CC-BY)](http://creativecommons.org/licenses/by/2.5/) and the usage is subject to the [Terms of Service](https://developers.google.com/freebase/terms). 

