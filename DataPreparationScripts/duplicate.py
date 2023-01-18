from collections import defaultdict
from random import choices
import datetime
import sys


# Read all the data from train, test, and valid. Then create a dictionary of all relations and their entities.
def create_triples(train_file, test_file, valid_file):
    # Dictionary of all relations / head&tails
    relations_dictionary = defaultdict(list)
    head_tail_dictionary = defaultdict(list)
    
    pair_id = 1
    # Read the data from train file
    with open(train_file,"r") as f1:
        for line in f1:
            try:
                # Read each line
                h,r,t = line.split(",")

                # set an ID for each head and tail pair
                current_id = head_tail_dictionary[(h, t)]
                if current_id == []:
                    head_tail_dictionary[(h, t)] = pair_id
                    relations_dictionary[r].append(pair_id)
                    pair_id += 1
                else: 
                    relations_dictionary[r].append(current_id)

            except:
                continue

    with open(test_file,"r") as f2:
        for line in f2:
            try:
                # Read each line
                h,r,t = line.split(",")

                # set an ID for each head and tail pair
                current_id = head_tail_dictionary[(h, t)]
                if current_id == []:
                    head_tail_dictionary[(h, t)] = pair_id
                    relations_dictionary[r].append(pair_id)
                    pair_id += 1
                else: 
                    relations_dictionary[r].append(current_id)

            except:
                continue

    with open(valid_file,"r") as f3:
        for line in f3:
            try:
                # Read each line
                h,r,t = line.split(",")

                # set an ID for each head and tail pair
                current_id = head_tail_dictionary[(h, t)]
                if current_id == []:
                    head_tail_dictionary[(h, t)] = pair_id
                    relations_dictionary[r].append(pair_id)
                    pair_id += 1
                else: 
                    relations_dictionary[r].append(current_id)

            except:
                continue

    # Sort relations_dictionary by the number of tuples - low to high
    sorted_relations_by_size  = sorted(relations_dictionary, key=lambda k: len(relations_dictionary[k]), reverse=False)

    return relations_dictionary, sorted_relations_by_size, head_tail_dictionary


# Randomly returns one of the duplicate relations in each duplicate pair
def duplicate_relations(all_triples, sorted_dict, i1, i2, threshold1 = 0.8, threshold2 = 0.8): 

    # List of duplicate relations to be deleted
    duplaicate_relations = []

    for i in range(i1, i2):
        r1 = sorted_dict[i]
        #print("r1: " + str(r1))
        v1 = all_triples[r1]

        for r2 in sorted_dict:
            #print("     for r2: " + str(r2))
            v2 = all_triples[r2]
            l_r1 = len(v1)
            l_r2 = len(v2)

            if l_r1/l_r2 < threshold2:
                #print("     break!")
                break

            if l_r2/l_r1 < threshold1: 
                #print("     continue")
                continue 

            if r1 != r2: 
                if r1 in duplaicate_relations or r2 in duplaicate_relations:
                    #print("     one of them is already in duplicate")
                    continue
                #print("     check duplicate?")
                overlap_list = list(set(v1) & set(v2))
                overlap = len(overlap_list)
            
                is_duplicate1 = overlap / len(v1)
                is_duplicate2 = overlap / len(v2)
                
                if is_duplicate1 >= threshold1 and is_duplicate2 >= threshold2:  
                    # Randomly choose one of them to be deleted
                    #print("     duplicate " + str(r1) + " and " + str(r2))
                    kf = choices([r1,r2], [0.5,0.5])
                    print("Duplicate: "+ str(r1)+ " " + str(r2) + " " + kf[0])
                    duplaicate_relations.append(kf[0])
   
    return duplaicate_relations


# remove redundant relations from the txt files
def remove_redundancy(input_filename, redundant_relations, output_filename):
    with open(input_filename, "r") as inf, open(output_filename, "w") as outf:
        for line in inf:
            try:
                # Read each line and check if the relation is cartesian
                h,r,t = line.split(",")
                if int(r) not in redundant_relations: 
                    new_line = line
                    outf.write( new_line)
                #else: 
                    #print("innnnn: ", r)
            except:
                continue


def writeTO(listf, output_filename):
    with open(output_filename, "w") as outf:
        for i in listf:
            try:
                outf.write( str(i) + "\n")
            except:
                continue

if __name__ =="__main__":

    input1 = sys.stdin.read()
    i1, i2 = input1.split()
    print("i1: "+ i1 + " i2: " + i2)
    i1 = int(i1)
    i2 = int(i2)
  
    print("reading the data!")
    all_triples, sorted_dict, ht_dict = create_triples("train.txt", "test.txt", "valid.txt")
    print(len(sorted_dict))
    print("finding duplicates!")
    duplaicate_relations = duplicate_relations(all_triples, sorted_dict, i1, i2)
    print("write to the file")
    #writeTO(duplaicate_relations, "ouuuuu")
    print("duplicate_relations: ")
    print(duplicate_relations)
    #for i in duplaicate_relations: 
        #print(" relation:  " + str(i) + " length: " + str(len(all_triples[str(i)])))
        #print(all_triples[str(i)])
    #print("removing from train")
    #remove_redundancy("train_RCCleaned.txt", duplaicate_relations, "train_RCDCleaned.txt")
    #print("removing from test")
    #remove_redundancy("test_RCCleaned.txt", duplaicate_relations, "test_RCDCleaned.txt")
    #print("removing from valid")
    #remove_redundancy("valid_RCCleaned.txt", duplaicate_relations, "valid_RCDCleaned.txt")
    print("Done!")
