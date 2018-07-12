# -*- coding: utf-8 -*-
"""
Created on Thu Jul 12 06:19:23 2018

@author: Admin
"""
import os
import re
import pickle
import nltk
from sklearn.datasets import load_files
os.chdir('C:\\Users\\Admin\\Documents\\GitHub\\Code\\AppliedAI\\Content\\17. Amazon Food Reviews Data Set\\Data\\review_polarity')
reviews=load_files('txt_sentoken/')
X,y=reviews['data'],reviews['target']

with open('X.pickle','wb') as f:
    pickle.dump(X,f)
    
with open('y.pickle','wb') as f:
    pickle.dump(y,f)
    
## Retriving the data from the pickle files
with open('X.pickle','rb') as f:
    X=pickle.load(f)

with open('y.pickle','rb') as f:
    y=pickle.load(f)
    

## Total # of reviews
print('Total # of review present: ',len(X))
print(X[0])
x0=X[0]
test=nltk.sent_tokenize(x0)

for i in range(0,len(X)):
        sentence=[]
        X[i]=X[i].lower()
        X[i]=re.sub(r'\d',' ',str(X[i]))
        X[i]=re.sub(r'\W',' ',str(X[i]))
        X[i]=re.sub(r'[~!@#$%^&*()\.\,\']',' ',str(X[i]))
        X[i]=re.sub(r'[`~!@#\$%\^\&*()_\-\=+\{\[\]\}\:\;\"\'\<\>\,\.\?\/\\\|]',' ',str(X[i]))
        X[i]=re.sub(r'\s+[a-zA-Z]\s+',' ',str(X[i]))
        X[i]=re.sub(r'\s+',' ',str(X[i]))
        #X[i]=[sentence.append(word) for word in nltk.word_tokenize(X[i]) if word!=nltk.corpus.stopwords.words('english')]

a=[1,2,3]
b=[2,5,6]
c=[]
c.append(b)
c.append(a)

stopwords=nltk.corpus.stopwords.words('english')
X_Defined=[]
for i in X:
    sentence_cleaned=[]
    sentence_stopwords=[]
    words=nltk.word_tokenize(i)
    for word in words:
        if word not in stopwords:
            sentence_cleaned.append(word)
        else:
            sentence_stopwords.append(word)
    X_Defined.append(sentence_cleaned)

len(X_Defined)
            
sentence="""Hey ~`!@#$%^&*()_-=+{][]:;"'"<,>.?/\| should @be # wheh \ there is /"""
sentence_modified=re.sub(r'[`~!@#\$%\^\&*()_\-\=+\{\[\]\}\:\;\"\'\<\>\,\.\?\/\\\|]',' ',sentence)
                            