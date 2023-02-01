import numpy as np
from collections import OrderedDict
import re
import pandas as pd

def find_edge_domain(edge_label):
    
    a = r'/(.*?)/'
    slotList = re.findall(a, edge_label)  
    return slotList[0]

def read_file(file_path):
    triples = []
    with open(file_path) as f:
        lines = f.readlines()
        for line in lines:
            triple = line.replace('\n', '').split(',')
            triples.append(triple)
    return triples

def get_id2label(file_path):
    id2label = {}
    with open(file_path) as f:
        lines = f.readlines()
        for line in lines:
            entry = line.replace('\n', '').split(',')
            label = entry[0]
            id = entry[1]
            id2label[id] = label
    return id2label

def get_entity_mid2label(file_path):
    entity_mid2label = {}
    with open(file_path) as f:
        lines = f.readlines()
        for line in lines:
            entry = line.replace('\n', '')
            indexs = [substr.start() for substr in re.finditer(",", entry)]
            if len(indexs) < 2:
                continue
            mid = entry[:indexs[0]]
            label = entry[indexs[0] + 1: indexs[-1]]
            entity_mid2label[mid] = label
    return entity_mid2label


if __name__ == "__main__":
    train_path = "/KGCExp/LargeScaleExperiments_DGLKE/FB1/data/train.txt"
    val_path = "/KGCExp/LargeScaleExperiments_DGLKE/FB1/data/valid.txt"
    test_path = "/KGCExp/LargeScaleExperiments_DGLKE/FB1/data/test.txt"

    train = read_file(train_path)
    val = read_file(val_path)
    test = read_file(test_path)

    all = train + val + test
    print(len(all))
    print(type(all))
    #all = list(set(all))
    np.save("all_instances.npy", all, allow_pickle = True)
    print("done save all_instances.npy")

    relation_id2label = get_id2label("/KGCExp/LargeScaleExperiments_DGLKE/FB1/data/relation2id.txt")
    np.save("relation_id2label.npy", relation_id2label, allow_pickle=True)
    print("done save relation_id2label.npy")

    entity_id2mid = get_id2label("/KGCExp/LargeScaleExperiments_DGLKE/FB1/data/entity2id.txt")
    np.save("entity_id2mid.npy", entity_id2mid, allow_pickle=True)
    print("done save entity_id2mid.npy")

    entity_id2mid = np.load("entity_id2mid.npy", allow_pickle=True).item()
    relation_id2label = np.load("relation_id2label.npy", allow_pickle=True).item()
    datagraph = np.load("all_instances.npy", allow_pickle=True)
    relation_triples = {}
    for triple in datagraph:
        rel = triple[1]
        sub = entity_id2mid[triple[0]]
        obj = entity_id2mid[triple[2]]
        relation = relation_id2label[rel]
        if relation not in relation_triples:
            relation_triples[relation] = []
        relation_triples[relation].append((sub, relation, obj))

    sorted_relation_triples = OrderedDict(sorted(relation_triples.items(), key=lambda x: len(x[1]), reverse = True))
    np.save("sorted_relation_triples.npy", sorted_relation_triples, allow_pickle=True)
    print("done save sorted_relation_triples.npy")

    domain_triples = {}
    domain_relations = {}
    sorted_relation_triples = np.load("sorted_relation_triples.npy", allow_pickle=True).item()


    for key in sorted_relation_triples:
        triples = sorted_relation_triples[key]
        domain = find_edge_domain(key)
        domain_triples.setdefault(domain, []).extend(triples)
        domain_relations.setdefault(domain, []).append(key)
    sorted_domain_triples = OrderedDict(sorted(domain_triples.items(), key=lambda x: len(x[1]), reverse = True))
    np.save("sorted_domain_triples.npy", sorted_domain_triples, allow_pickle=True)
    print("done save sorted_domain_triples.npy")
    print("domain", "#triples", "#relations")
    for domain in sorted_domain_triples:
        print(domain, len(sorted_domain_triples[domain]), len(domain_relations[domain]))
    
    first_12_domain_num_triples = sum([len(sorted_domain_triples[domain]) for domain in list(sorted_domain_triples.keys())[:12]])
    all_num_triples = sum([len(sorted_domain_triples[domain]) for domain in sorted_domain_triples])
    proportion = first_12_domain_num_triples / all_num_triples
    print("proportion of first 12 domains: ", proportion)
   




