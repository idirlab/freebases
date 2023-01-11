import pandas as pd
from sklearn.model_selection import train_test_split

def splitData(filename, train_size=0.9, test_size = 0.5):
    if train_size + (2 * test_size/10) != 1: 
        print("Error in the size of train, valid, test!")

    df = pd.read_csv(filename, delimiter = ',', header = None)

    X = df.copy()

    # split the data to train and remaining dataset
    X_train, X_rem = train_test_split(X,train_size = train_size)

    # define valid_size=0.5 (50% of remaining data)
    X_valid, X_test= train_test_split(X_rem, test_size= test_size)

    # write train, valid, test into files
    X_train.to_csv('train.txt', sep = ',', header = None, index = None)
    X_test.to_csv('test.txt', sep = ',', header = None, index = None)
    X_valid.to_csv('valid.txt', sep = ',', header = None, index = None)

    return X_train, X_valid, X_test

if __name__ =="__main__":

    X_train, X_valid, X_test = splitData('FB2ID.txt')
