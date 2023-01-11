from collections import defaultdict

def read_dict(filename):
    dic = defaultdict(list)

    with open(filename,"r") as f1:
        for line in f1:
            try:
                k, v = line.split(',')
                dic[k].append(v)

            except:
                continue

    return dic


def replaceWID(dicE, dicR, filename):

    triplesID = []

    with open(filename,"r") as f1:
        for line in f1:
            try:
                h, r, t = line.split(',')
                h2 = dicE[h.rstrip()]
                h2 = str(h2[0]).rstrip()

                r2 = dicR[r.rstrip()]
       	       	r2 = str(r2[0]).rstrip()

                t2 = dicE[t.rstrip()]
       	       	t2 = str(t2[0]).rstrip()
                
                tmp = h2 + "," + r2 + "," + t2 + "\n"
                triplesID.append(tmp)

            except:
                continue

    return triplesID

def write_to_file(list1, filename):
    with open(filename,"w") as f1:
        for l in list1:
            try:
                f1.write(l)
            except:
                continue

if __name__ =="__main__":

    filename = "FB2.txt"

    dicE = read_dict("entity2id.txt")
    dicR = read_dict("relation2id.txt")

    triplesID = replaceWID(dicE, dicR, filename)
    write_to_file(triplesID,"FB2ID.txt")
