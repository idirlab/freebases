from collections import defaultdict
import pandas as pd 

# Reads all data from train, test, and valid. Then creates a dictionary of all relations and their entities(h-t pairs).
def create_triples(train_file, test_file, valid_file):
    # dictionary of all relations,head-tail pairs
    relations_dictionary = defaultdict(list)

    # Read the data from train file
    with open(train_file,"r") as f1:
        for line in f1:
            try:
                # Read each line
                h,r,t = line.split(",")

                # Creat a dictionary for relations, add their heads and tails  
                relations_dictionary[r].append([h,t])

            except:
                continue

    with open(test_file,"r") as f2:
        for line in f2:
            try:
                # Read each line
                h,r,t = line.split(",")

                # Creat a dictionary for relations, add their heads and tails  
                relations_dictionary[r].append([h,t])

            except:
                continue

    with open(valid_file,"r") as f3:
        for line in f3:
            try:
                # Read each line
                h,r,t = line.split(",")

                # Creat a dictionary for relations, add their heads and tails  
                relations_dictionary[r].append([h,t])

            except:
                continue

    return relations_dictionary

# Find cartesian relations
def cartesian_relations(all_triples, threshold = 0.8): 
    size_of_all_relations = len(all_triples)
    print("All rels: " , size_of_all_relations)
    size_of_cartesian_relations = 0 

    # list of cartesian relations
    cartesian_relations_output = []

    for k1, v1 in all_triples.items():  
        
        v1_dataframe= pd.DataFrame(v1, columns =['Head', 'Tail'])
        # Size of head set
        s_size = len(pd.unique(v1_dataframe['Head']))
        # Size of tail set
        o_size = len(pd.unique(v1_dataframe['Tail']))

        r_size = len(v1)

        # Check if the relation(k1) is cartesian
        if r_size / (s_size * o_size) >= threshold and r_size > 1: 
            cartesian_relations_output.append(k1)
            size_of_cartesian_relations += 1

    percentage_of_cartesian_relations = 100 * size_of_cartesian_relations / size_of_all_relations

    return cartesian_relations_output, percentage_of_cartesian_relations


# remove redundant relations from the txt files
def remove_redundancy(input_filename, redundant_relations, output_filename):
    with open(input_filename, "r") as inf, open(output_filename, "w") as outf:
        for line in inf:
            try:
                # Read each line and check if the relation is cartesian
                h,r,t = line.split(",")
                if r not in redundant_relations: 
                    new_line = line
                    outf.write( new_line)
            except:
                continue


if __name__ =="__main__":
    print("start")
    all_triples = create_triples("train.txt", "test.txt", "valid.txt")
    print("Just read all triples")
    cartesian_relations_output , percentage_of_cartesian_relations= cartesian_relations(all_triples)
    print("found cartesian rels, percentage: ")
    print(percentage_of_cartesian_relations)
    #print(cartesian_relations_output)
    remove_redundancy("train.txt", cartesian_relations_output, "train-cr.txt")
    print("removed from train")
    remove_redundancy("test.txt", cartesian_relations_output, "test-cr.txt")
    print("removed from test")
    remove_redundancy("valid.txt", cartesian_relations_output, "valid-cr.txt")
    print("removed from valid and done!")
