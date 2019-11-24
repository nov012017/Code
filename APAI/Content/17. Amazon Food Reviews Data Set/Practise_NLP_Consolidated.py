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
import heapq
import numpy as np

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

freq_words=heapq.nlargest(100,word2count,key=word2count.get)

X_TopWords=[]
for data in X_POSCleaned:
    vector=[]
    for word in freq_words:
        if word in nltk.word_tokenize(data):
            vector.append(1)
        else:
            vector.append(0)
    X_TopWords.append(vector)
    
X_TopWords_Array=np.asarray(X_TopWords)

## idf matrix
#idf=log((total # of documents)/total # of documents the word present))
words_idfs={}
for word in freq_words:
    frequency=0
    for data in X_POSCleaned:
        if word in nltk.word_tokenize(data):
            frequency+=1
    words_idfs[word]=np.log(len(X_POSCleaned)/frequency+1)
    
## TF Matrix
## TF= (TOTAL # OF OCCURENCE OF A WORD IN A DOCUMENT)/(TOTAL NUMBER OF WORDS IN THAT DOCUMENT)
words_TF={}
for word in freq_words:
    word_doc_freq=[]
    for data in X_POSCleaned:
        frequency_tf=0
        for word_token in nltk.word_tokenize(data):
            if word==word_token:
                frequency_tf+=1
        tf_word=frequency/len(nltk.word_tokenize(data))
        word_doc_freq.append(tf_word)
    words_TF[word]=word_doc_freq

tfidf_matrix=[]
for word in words_TF.keys():
    tfidf_word=[]
    for value in words_TF[word]:
        tfidf_score=value*words_idfs[word]
        tfidf_word.append(tfidf_score)
    tfidf_matrix.append(tfidf_word)

tfidf_matrix_array=np.asarray(tfidf_matrix)

## TF IDF FUNCTION 
from sklearn.feature_extraction.text import TfidfVectorizer
vectorizer=TfidfVectorizer(ngram_range=(1,2),min_df=0.01,max_df=0.6,analyzer='word',
                           strip_accents='ascii',
                           stop_words=None,
                           lowercase=False,max_features=2200)
vectorizer.fit(X_Defined)
vect=vectorizer.transform(X_Defined)
vect_array=vect.toarray()

tfidf_features=vectorizer.get_feature_names()
tfidf_parameters=vectorizer.get_params()
vectorizer.stop_words_
vectorizer.vocabulary_
vect_idf=vectorizer.idf_

for i,comp in enumerate(vectorizer.vocabulary_):
    component_terms=zip(i,comp)
    print(component_terms)


## Not working -- to match the output of vect_idf values
vect_sum=[]
for i in range(0,vect.shape[1]):
    sum1=0
    for j in range(0,len(vect)):
        sum=vect[j][i]
        sum1+=sum
    vect_sum.append(sum1)
    
n=2
bigrams={}
for j in range(len(X_Defined)):
    words=nltk.word_tokenize(X_Defined[j])
    for i in range(len(words)-n):
        gram=' '.join(words[i:i+n])
        if gram not in bigrams.keys():
            bigrams[gram]=[]
        bigrams[gram].append(words[i+n])
        
import random         
currentgram=' '.join(words[0:n])
result=currentgram
for i in range(30):
    if currentgram not in bigrams.keys():
        break
    possibilities=bigrams[currentgram]
    next=possibilities[random.randrange(len(possibilities))]
    result+=' '+next
rwords=nltk.word_tokenize(result)
currentgram=' '.join(rwords[len(rwords)-n:len(rwords)])

from sklearn.decomposition import TruncatedSVD
TruncSVD=TruncatedSVD(n_components=4,n_iter=100)
TruncSVD.fit(vect)

row1=TruncSVD.components_[3]
components=TruncSVD.components_
explainedvariance=TruncSVD.explained_variance_
explainedvarianceratio=TruncSVD.explained_variance_ratio_.sum()
explainedvariance[0]/explainedvarianceratio
singularvalue=TruncSVD.singular_values_

term=vectorizer.get_feature_names()

concept_words={}

for i,comp in enumerate(TruncSVD.components_):
    componentTerms=zip(term,comp)
    sortedTerms=sorted(componentTerms,key=lambda X:X[1],reverse=True)
    sortedTerms=sortedTerms[:10]
    print("\nConcept",i,":")
    for terms in sortedTerms:
        print(terms)
    concept_words["Concept"+str(i)]=sortedTerms

final_score=[]
for key in concept_words.keys():
    sentence_score=[]
    for i in X_Defined:
        words=nltk.word_tokenize(i)
        score=0
        for word in words:
            for word_with_score in concept_words[key]:
                if word==word_with_score[0]:
                    score+=word_with_score[1]
        sentence_score.append(score)
    final_score.append(sentence_score)
    
### SYNONYMS
from nltk.corpus import wordnet as wn
synonyms=[]
antonyms=[]
for syn in wn.synsets('good'):
    for s in syn.lemmas():
        synonyms.append(s.name())
        for a in s.antonyms():
            antonyms.append(a.name())
print(set(synonyms))
print(set(antonyms))

## 




        