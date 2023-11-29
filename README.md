
# Comprehensive Analysis of Freebase and Dataset Creation for Robust Evaluation of Knowledge Graph Link Prediction Models

## Overview

This repository contains the dataset, preprocessing scripts, and experiment results of the paper [Comprehensive Analysis of Freebase and Dataset Creation for Robust Evaluation of Knowledge Graph Link Prediction Models](https://openreview.net/pdf?id=ikw7gqAGz7A), where we lay out a comprehensive analysis of the challenges and impacts associated with three idiosyncrasies(Reverse Triples, Mediator Nodes, and Type System) of Freebase, a large-scale, open-domain knowledge graph on Knowledge Graph Completion tasks such as link prediction. 

Freebase is amongst the largest public cross-domain KGs that store common facts. It possesses several data modeling idiosyncrasies rarely found in comparable datasets such as Wikidata, YAGO, and so on. Though closed in 2015, Freebase still serves as an important knowledge graph in intelligent tasks. We checked all full-length papers that use datasets commonly used for link prediction and were published in 12 top conferences during their latest versions, in 2022. The 12 conferences are AAAL, IJCAI, WWW, KDD, ICML, ACL, EMNLP, NAACL, SIGIR, NeurIPS, SIGMOD, and VLDB. That amounts to 53 papers. 48 out of the 53 papers used datasets produced from Freebase, while only 8 used datasets from Wikidata. The papers and the datasets used in the papers are listed in the file **papers.xlsx**. 

**Reverse Triples**

When a new fact was included in Freebase, it would be added as a pair of reverse triples. For instance, *(A Room With A View,167
/film/film/directed_by, James Ivory)* and *(James Ivory, film/director/film, A Room With A View)* form a pair of reverse triples. They have the same semantic meaning.

**Mediator Nodes**

Mediator nodes, also called CVT nodes, are used in Freebase to represent n-ary relationships. The figure below shows a CVT node connected to an award, a nominee, and a work. This or similar approach is necessary for accurate modeling of the real world.

![image](https://user-images.githubusercontent.com/44850160/187091882-0164271e-423e-4098-9af6-2105dd95f4f5.png)

**Type System**

Freebase categorizes each topic into one or more types and each type into one domain. Furthermore, the triple instances satisfy pseudo constraints as if they are governed by a rigorous type system. Specifically, 1) given a node, its types set up constraints on the labels of its properties; the type segment in the label of an edge (which is different from the edge type) in most cases belongs to one of the types of the subject node. 2) Given an edge type and its edge instances, there is almost a function that maps from the edge type to a type that all subjects in the edge instances belong to, and similarly almost such a function for objects. 

## Dataset

Four variants of the Freebase dataset are provided by the inclusion/exclusion of various data modeling idiosyncrasies, which enables researchers to leverage or avoid such features based on the nature of their tasks. **The dataset can be downloaded from this [link](https://zenodo.org/records/7909511).**

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
The dataset consists of the four variants of the Freebase dataset as well as related mapping/support files. For each variant, we made three kinds of files available:
- **Subject matter triples file**
  - *fb+/-CVT+/-REV* 
    One folder for each variant. In each folder, there are 5 files: train.txt, valid.txt, test.txt, entity2id.txt, relation2id.txt
    Subject matter triples are the triples that belong to subject matter domains—domains describing real-world facts.
    - Example of a row in train.txt, valid.txt, and test.txt
      - > 2, 192, 0 
    - Example of a row in entity2id.txt: 
      - /g/112yfy2xr, 2 
    - Example of a row in relation2id.txt: 
      - /music/album/release_type, 192 
    - Explanation
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
      - The entity with MID "/g/11b78qtr5m" has the name "Viroliano Tries Jazz" in English.
  - *object_ids*: Each row maps the MID of a Freebase object to its user-friendly identifier.
    - Example
      - >/m/05v3y9r, /type/object/id, "/music/live_album/concert"
    - Explanation
      - The entity with MID "/m/05v3y9r" can be interpreted by humans as a music concert live album.
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
      - The object with MID "/m/010h8tp2" in Freebase is a property(relation/edge), it has the label "/comedy/comedy_group/members" and has id "47178867" in our dataset.
  - *uri_original2simplified* and *uri_simplified2original*: The mapping between the original URI and simplified URI and the mapping between simplified URI and original URI respectively.
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

We conducted all the link prediction experiments on four datasets using the DGL-KE framework ([Zheng et al.,2020](https://arxiv.org/pdf/2004.08532.pdf)). 

The hyperparameters used for each experiment, its training/test time, and more details can be found in the script provided for each dataset. 

The results of these experiments on our datasets are shown in the table below. 
<table class="tg">
<thead>
  <tr>
    <th class="tg-0pky"></th>
    <th class="tg-c3ow" colspan="4">FB-CVT-REV</th>
    <th class="tg-c3ow" colspan="4">FB-CVT+REV</th>
    <th class="tg-c3ow" colspan="4">FB+CVT-REV</th>
    <th class="tg-c3ow" colspan="4">FB+CVT+REV</th>
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
    <td class="tg-c3ow">0.806</td>
    <td class="tg-c3ow">5.869</td>
    <td class="tg-c3ow">0.757</td>
    <td class="tg-c3ow">0.884</td>
    <td class="tg-0pky">0.976</td>
    <td class="tg-0pky">1.529</td>
    <td class="tg-0pky">0.968</td>
    <td class="tg-0pky">0.988</td>
    <td class="tg-0pky">0.781</td>
    <td class="tg-0pky">4.850</td>
    <td class="tg-0pky">0.708</td>
    <td class="tg-0pky">0.902</td>
    <td class="tg-0pky">0.970</td>
    <td class="tg-0pky">1.464</td>
    <td class="tg-0pky">0.957</td>
    <td class="tg-0pky">0.989</td>
  </tr>
  <tr>
    <td class="tg-0pky">DistMult</td>
    <td class="tg-c3ow">0.703</td>
    <td class="tg-c3ow">70.498</td>
    <td class="tg-c3ow">0.664</td>
    <td class="tg-c3ow">0.775</td>
    <td class="tg-0pky">0.952</td>
    <td class="tg-0pky">9.239</td>
    <td class="tg-0pky">0.941</td>
    <td class="tg-0pky">0.970</td>
    <td class="tg-0pky">0.612</td>
    <td class="tg-0pky">81.841</td>
    <td class="tg-0pky">0.562</td>
    <td class="tg-0pky">0.704</td>
    <td class="tg-0pky">0.927</td>
    <td class="tg-0pky">12.924</td>
    <td class="tg-0pky">0.913</td>
    <td class="tg-0pky">0.951</td>
  </tr>
  <tr>
    <td class="tg-0pky">ComplEx</td>
    <td class="tg-c3ow">0.719</td>
    <td class="tg-c3ow">67.740</td>
    <td class="tg-c3ow">0.684</td>
    <td class="tg-c3ow">0.783</td>
    <td class="tg-0pky">0.958</td>
    <td class="tg-0pky">8.437</td>
    <td class="tg-0pky">0.950</td>
    <td class="tg-0pky">0.972</td>
    <td class="tg-0pky">0.624</td>
    <td class="tg-0pky">83.205</td>
    <td class="tg-0pky">0.577</td>
    <td class="tg-0pky">0.708</td>
    <td class="tg-0pky">0.928</td>
    <td class="tg-0pky">13.278</td>
    <td class="tg-0pky">0.915</td>
    <td class="tg-0pky">0.951</td>
  </tr>
    <tr>
    <td class="tg-0pky">TransR</td>
    <td class="tg-c3ow">0.663</td>
    <td class="tg-c3ow">58.553</td>
    <td class="tg-c3ow">0.620</td>
    <td class="tg-c3ow">0.743</td>
    <td class="tg-0pky">0.944</td>
    <td class="tg-0pky">5.982</td>
    <td class="tg-0pky">0.931</td>
    <td class="tg-0pky">0.967</td>
    <td class="tg-0pky">0.640</td>
    <td class="tg-0pky">47.524</td>
    <td class="tg-0pky">0.580</td>
    <td class="tg-0pky">0.754</td>
    <td class="tg-0pky">0.935</td>
    <td class="tg-0pky">6.071</td>
    <td class="tg-0pky">0.916</td>
    <td class="tg-0pky">0.969</td>
  </tr>
  <tr>
    <td class="tg-0pky">RotatE</td>
    <td class="tg-c3ow">0.804</td>
    <td class="tg-c3ow">75.721</td>
    <td class="tg-c3ow">0.780</td>
    <td class="tg-c3ow">0.845</td>
    <td class="tg-0pky">0.962</td>
    <td class="tg-0pky">10.431</td>
    <td class="tg-0pky">0.956</td>
    <td class="tg-0pky">0.974</td>
    <td class="tg-0pky">0.736</td>
    <td class="tg-0pky">68.436</td>
    <td class="tg-0pky">0.699</td>
    <td class="tg-0pky">0.807</td>
    <td class="tg-0pky">0.948</td>
    <td class="tg-0pky">10.263</td>
    <td class="tg-0pky">0.938</td>
    <td class="tg-0pky">0.969</td>
  </tr>
</tbody>
</table>


Another way of evaluating embedding models is to find their performance on triple classification. This task is the binary classification of triples regarding whether they are true or false facts. The results of our triple classification task are shown in the tables below.

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

The experiments on triple classification were done using the LibKGE framework. ([Broscheit et al.,2020](https://aclanthology.org/2020.emnlp-demos.22.pdf))

## Scripts

### Data Preparation Scripts

- **parse_triples.sh** script is used for URI simplification.

- **FBDataDump.sh** is a script that runs parse_triples.sh and creates different MySQL tables from Freebase data dump. For example, tables for domains, types, properties, and entities. 
    Command to run FBDataDump.sh:
   
  ``
  ./FBDataDump.sh mysql_username mysql_password
  ``

    After running FBDataDump.sh, you may want to run one of the four scripts provided for each variant. All these four scripts detach the subject matter triples from  the metadata and administrative triples. In addition, all these scripts create a type system for the final dataset. Command to run **FBx.sh**, where x ∈ {1,2,3,4}: 

  ``
  ./FBx.sh mysql_username mysql_password
  ``
- If you need to remove all the reverse triples as well as all the CVT nodes, you can run **FB1.sh**.

- To keep the reverse triples but remove the CVT nodes, you can run **FB2.sh**.

- To keep the CVT nodes but to remove the reverse triples, you can run **FB3.sh**.

- To keep both CVT nodes and reverse triples, you can run script **FB4.sh**.


### Experiments Scripts

We did experiments on the four variants of Freebase as well as FB15K and FB-15K-237 using link prediction models like TransE, DistMult, ComplEx, RotatE, etc. The scripts to run the experiments are at ExperimentsScripts/ ending with .sh. An example of running the DistMult model on FB1 is as below.

``
dglke_train --model_name DistMult --dataset Freebase --data_path ./data --format udd_hrt  \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt  --batch_size 1024 --neg_sample_size 256 --hidden_dim 400 --gamma 143.0 \
--lr 0.08 --batch_size_eval 1000 --test -adv --mix_cpu_gpu --num_proc 8 --gpu 0 1 --max_step 300000 --neg_sample_size_eval 1000 \
--eval_interval 100000 --log_interval 1000 --async_update --rel_part --force_sync_interval 10000 --num_thread 4 --no_save_emb --delimiter ,
``


### Related Work
Please feel free to check out another paper of ours related to this topic: [Realistic re-evaluation of knowledge graph completion methods: An experimental study](https://dl.acm.org/doi/pdf/10.1145/3318464.3380599)


## License

The dataset and code are made available under the [CC0 1.0 Universal](https://github.com/idirlab/freebases/blob/main/LICENSE).

Note: [Freebase Data Dumps](https://developers.google.com/freebase) is provided free of charge for any purpose. It is distributed under the [Creative Commons Attribution (aka CC-BY)](http://creativecommons.org/licenses/by/2.5/) and the usage is subject to the [Terms of Service](https://developers.google.com/freebase/terms). 

