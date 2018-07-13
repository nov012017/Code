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
from nltk.stem import PorterStemmer
from nltk.stem import WordNetLemmatizer
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
    X_Defined.append(' '.join(sentence_cleaned))
### Performing stemming on each of the reviews
stemmer=PorterStemmer()
X_Stemmed=[]
for i in X_Defined:
    word=[]
    words=nltk.word_tokenize(i)
    word=[stemmer.stem(word) for word in words]
    X_Stemmed.append(' '.join(word))
    
    
## Performing Lemmatization on each of the reviews
lemmatizer=WordNetLemmatizer()
X_Lemmatized=[]
for i in X_Defined:
    word=[]
    words=nltk.word_tokenize(i)
    word=[lemmatizer.lemmatize(word) for word in words]
    X_Lemmatized.append(' '.join(word))
    
## POS Tagging
X_POSTagged=[]
for i in X_Defined:
    word=[]
    words_tagged=[]
    words=nltk.word_tokenize(i)
    tagged_words=nltk.pos_tag(words)
    X_POSTagged.append(tagged_words)

len(X_POSTagged)

X_POSCleaned=[]
for i in range(len(X_POSTagged)):
    not_noun_word=[]
    for tw in X_POSTagged[i]:
        if tw[1]!='NN':
            not_noun_word.append(tw[0])
    X_POSCleaned.append(' '.join(not_noun_word))
            
word2count={}
for i in range(len(X_POSCleaned)):
    words=nltk.word_tokenize(X_POSCleaned[i])
    for word in words:
        if word not in word2count.keys():
            word2count[word]=1
        else:
            word2count[word]+=1
                            