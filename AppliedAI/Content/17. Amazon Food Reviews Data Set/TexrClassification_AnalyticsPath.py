# -*- coding: utf-8 -*-
"""
Created on Sun Jul  8 18:31:03 2018

@author: Admin
"""

import os 
import pandas as pd
import numpy as np
import re
import nltk
from nltk.corpus import stopwords
from nltk.stem import WordNetLemmatizer
from nltk.stem.porter import *
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.feature_extraction.text import TfidfTransformer
from itertools import islice
from sklearn.naive_bayes import MultinomialNB
import pickle

os.chdir("C:\\Users\\Admin\\Desktop\\July 8 2018\\textclassificationusecasedataandcode\\News")

df = pd.read_csv("train.csv", header=None)

df.columns = ["Class","ShortDesc","Desc"]
df.head()

stops = stopwords.words('english')
ad_stopwords = ['monday', 'like', 'com', 'use', 'help', 'create', 'time', 'want', 'a', 'about', 'above', 'across', 'after', 'afterwards'] 
stops.extend(ad_stopwords)     

##REGEX FOR DATE REMOVAL
#import re
txt='Monday, April, 4, 2016, 10:16:06'
re1='(Monday)'	# Day Of Week 1
re2='.*?'	# Non-greedy match on filler
re3='(April)'	# Month 1
re4='.*?'	# Non-greedy match on filler
re5='(4)'	# Day 1
re6='.*?'	# Non-greedy match on filler
re7='(2016)'	# Year 1
re8='.*?'	# Non-greedy match on filler
re9='(10:16:06)'	# HourMinuteSec 1

rg = re.compile(re1+re2+re3+re4+re5+re6+re7+re8+re9,re.IGNORECASE|re.DOTALL)
m = rg.search(txt)
if m:
    dayofweek1=m.group(1)
    month1=m.group(2)
    day1=m.group(3)
    year1=m.group(4)
    time1=m.group(5)
    
#import re
re1='(b)'	# Variable Name 1
re2='.*?'	# Non-greedy match on filler
re3='(4\\/04\\/2016)'	# DDMMYYYY 1

rd = re.compile(re1+re2+re3,re.IGNORECASE|re.DOTALL)
m = rg.search(txt)
if m:
    var1=m.group(1)
    ddmmyyyy1=m.group(2)

#import re
txt='\\\\r\\\\r____________________________\\\\r'

re1='(\\\\\\\\r\\\\\\\\r____________________________\\\\\\\\r)'	# Windows UNC 1

rt = re.compile(re1,re.IGNORECASE|re.DOTALL)
m = rg.search(txt)
if m:
    unc1=m.group(1)

#import nltk
def _remove_noise(input_text):
    input_text = str(input_text).encode('ascii', 'ignore')
    input_text = str(input_text).replace(",", "")
    #input_text = str(input_text).replace("\'\\", "")
    #input_text = str(input_text).replace("\'\", "")
    input_text = re.sub(rg, ' ', input_text)
    #input_text = re.sub([[:punct:]], '', input_text) -- this is a step in R 
    input_text = re.sub(rd, ' ', input_text)
    input_text = re.sub(rt, ' ', input_text)
    words = str(input_text).split()
    pos_words = nltk.pos_tag(words)
    noise_free_words = [i[0] for i in pos_words if i[1] in ('NN')]
    noise_free_words = [word for word in noise_free_words if word.lower() not in stops]
    return noise_free_words

df["cleaned"] = df.Desc.apply(_remove_noise)


lemmatizer = WordNetLemmatizer()
df['stemmed'] = df.cleaned.map(lambda x: ' '.join([lemmatizer.lemmatize(y) for y in x]))
df.stemmed.head()

cvec = CountVectorizer(stop_words=stops, min_df=.001, max_df=.99, ngram_range=(1,2))
cvec.fit(df.stemmed)
len(cvec.vocabulary_)

cvec.vocabulary_

len(cvec.get_feature_names())

cvec_counts = cvec.transform(df.stemmed).toarray()
