from collections import defaultdict

def relation_dict(filename):
    dic = defaultdict(list)
    i = 0 
    
    with open(filename,"r") as f1:
        for line in f1:
            try:
                h, r ,t = line.split(',')
                if r not in dic: 
                    dic[r].append(i)
                    i = i + 1
            except:
                print("error: ", line)
                continue

    return dic

def entity_dict(filename):
    dic = defaultdict(list)
    i = 0

    with open(filename,"r") as f1:
        for line in f1:
            try:
                h, r ,t = line.split(',')
                h = h.rstrip()
                t = t.rstrip()
                if h not in dic:
                    dic[h].append(i)
                    i = i + 1
                if t not in dic: 
                    dic[t].append(i)
                    i = i + 1 
            except:
                print("error: ", line)
                continue

    return dic

def write_to_file_dic(dic, filename):
    with open(filename,"w") as f1:
        for k,v in dic.items():
            try:
                l = str(k)+ "," + str(v[0]) + "\n"
                f1.write(l)
            except:
                continue

if __name__ =="__main__":
    filename = "FB2.txt"
    dicR = relation_dict(filename)
    write_to_file_dic(dicR, "relation2id.txt")

    dicE = entity_dict(filename)
    write_to_file_dic(dicE, "entity2id.txt")
