# -*- coding: utf-8 -*-
"""
Created on Thu Jul  5 06:50:07 2018

@author: Admin
"""

import numpy as np
import re
import pandas as pd
import nltk
from sklearn.datasets import load_files
from nltk.corpus import stopwords
import pickle
import os
os.chdir('C:\\Users\\Admin\\Documents\\GitHub\\Code\\AppliedAI\\Content\\17. Amazon Food Reviews Data Set\\Data\\review_polarity')

reviews=load_files('txt_sentoken/')
X,y =reviews.data,reviews.target

## Storing as piclkle files
with open('X.pickle','wb') as f:
    pickle.dump(X,f)

with open('y.pickle','wb') as f:
    pickle.dump(y,f)
    
with open('X.pickle','rb') as f:
    X=pickle.load(f)
    
with open('y.pickle','rb') as f:
    y=pickle.load(f)
    
## Pre porcessing
## Creating a corpus
corpus=[]
for i in range(0,len(X)):
    review=re.sub(r'\W',' ',str(X[i]))
    review=review.lower()
    review=re.sub(r'\s+[a-z]\s+',' ',review)
    review=re.sub(r'^[a-z]\s+',' ',review)
    review=re.sub(r'\s+',' ',review)
    corpus.append(review)

##Bag words model
from sklearn.feature_extraction.text import CountVectorizer
vectorizer=CountVectorizer(max_features=2000,min_df=3,max_df=0.6,stop_words=stopwords.words('english'))
X1=vectorizer.fit_transform(corpus).toarray()


from sklearn.feature_extraction.text import TfidfTransformer
transformer=TfidfTransformer()
X2=transformer.fit_transform(X1).toarray()

from sklearn.feature_extraction.text import TfidfVectorizer
vectorizer=TfidfVectorizer(max_features=2000,min_df=3,max_df=0.6,stop_words=stopwords.words('english'))
X1=vectorizer.fit_transform(corpus).toarray()

from sklearn.model_selection import train_test_split
text_train, text_test,sent_train,sent_test=train_test_split(X1,y,test_size=0.2,random_state=0)

from sklearn.linear_model import LogisticRegression
classifier=LogisticRegression()
classifier.fit(text_train,sent_train)
sent_pred=classifier.predict(text_test)

coefficients=classifier.coef_

from sklearn.metrics import confusion_matrix
cm=confusion_matrix(sent_test,sent_pred)

with open('classifier.pickle','wb') as f:
    pickle.dump(classifier,f)

with open('tfidfmodel.pickle','wb') as f:
    pickle.dump(vectorizer,f)



