import pandas as pd

data = pd.read_csv('data.csv', delimiter=',', decimal=",")

data['MRR'] = pd. to_numeric(data['MRR']) 
data['MR'] = pd. to_numeric(data['MR']) 
data['HITS@1'] = pd. to_numeric(data['HITS@1']) 
data['HITS@3'] = pd. to_numeric(data['HITS@3']) 
data['HITS@10'] = pd. to_numeric(data['HITS@10']) 

df = data.groupby(['dge']).mean()
df['size'] = data.groupby(['dge']).size()
df['id'] = df.index

#map1 = pd.read_csv('map.txt', sep="\t", header=None, names = ['label', 'id'])
map1 = pd.read_csv('map.txt', delimiter=',', header=None, names = ['label', 'id'])
df2 = df.set_index('id').join(map1.set_index('id'))

df2.to_csv("data2.csv", encoding='utf-8', index=True)
