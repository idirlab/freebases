## Experiments and Results

We conducted all the link prediction experiments on four datasets using DGL-KE framework ([Zheng et al.,2020](https://arxiv.org/pdf/2004.08532.pdf)). 

The hyperparameters used for each experiment, its training/test time, and more details can be found in the script provided for each dataset 

In the tables below, an upward/downward arrow beside a measure indicates that methods with greater/smaller values by that measure possess higher accuracy.

The results of these experiments on FB1, FB2, FB3, and FB4 dataset are shown in the table below. 
![This is an image](https://github.com/idirlab/freebases/blob/main/Experiments/FB1234.png?raw=true)

The results of these experiments on FB15K and FB15K-237 dataset are shown in the table below. 
![This is an image](https://github.com/idirlab/freebases/blob/main/Experiments/FB15KvsFB15K-237.png?raw=true)

We also provide the results of type filtering – removing type inconsistent results from the ranked list to showcase how type system can help evaluating embedding models on the link prediction task. The results are shown in the table below. 
![This is an image](https://github.com/idirlab/freebases/blob/main/Experiments/tf.png?raw=true)

Another way of evaluation embedding models is to find their performance on triple classification. This task is the binary classification of triples regarding whether they are true or false facts. The results of our triple classification task are shown in the tables below.
![This is an image](https://github.com/idirlab/freebases/blob/main/Experiments/tct.png?raw=true)
![This is an image](https://github.com/idirlab/freebases/blob/main/Experiments/tch.png?raw=true)
