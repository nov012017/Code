# -*- coding: utf-8 -*-
"""
Created on Wed Jul 18 07:08:15 2018

@author: Admin
"""

import numpy as np
import nltk
import pandas as pd
from IPython.display import display
from tqdm import tqdm
#from collections import counter
import ast
import os

import matplotlib.pyplot as plt
import matplotlib.mlab as mlab
import seaborn as sb

%matplotlib inline

os.chdir("C:\\Users\\Admin\\Desktop\\Analytics Path\\Data\\Kaggle\\abcnews-date-text")
raw_data_actual=pd.read_csv("abcnews_date_text.csv",parse_dates=[0], infer_datetime_format=True)
raw_data=raw_data_actual.iloc[:5000,]
reindexed_data = raw_data['headline_text']
reindexed_data_index = raw_data['publish_date']

display(raw_data.head())

def get_top_n_words(n_top_words,count_vectorizer,text_data):
    '''returns a tuple of the top n words in a sample and their accompanying counts, 
            given a CountVectorizer object and text sample'''
    vectorized_headlines = count_vectorizer.fit_transform(text_data.as_matrix())
    vectorized_total = np.sum(vectorized_headlines, axis=0)
    word_indices = np.flip(np.argsort(vectorized_total)[0:], 1)
    word_values = np.flip(np.sort(vectorized_total)[0:],1)
    word_vectors = np.zeros((n_top_words, vectorized_headlines.shape[1]))
    for i in range(n_top_words):
        word_vectors[i,word_indices[0,i]] = 1
    words = [word[0].encode('ascii').decode('utf-8') for word in count_vectorizer.inverse_transform(word_vectors)]
    return(words,word_values[0,:n_top_words].tolist()[0])


from sklearn.feature_extraction.text import CountVectorizer
count_vectorizer = CountVectorizer(stop_words='english')
words, word_values = get_top_n_words(n_top_words=20, count_vectorizer=count_vectorizer, text_data=reindexed_data)

fig,ax=plt.subplots(figsize=(16,8))
ax.bar(range(len(words)),word_values)
ax.set_xticks(range(len(words)))
ax.set_xticklabels(words)
ax.set_title('Top Words')

while True:
    try:
        tagged_headlines = pd.read_csv('abcnews-pos-tagged.csv', index_col=0)
        word_counts = [] 
        pos_counts = {}

        for headline in tagged_headlines[u'tags']:
            headline = ast.literal_eval(headline)
            word_counts.append(len(headline))
            for tag in headline:
                if tag[1] in pos_counts:
                    pos_counts[tag[1]] += 1
                else:
                    pos_counts[tag[1]] = 1

    except IOError:
        tagged_headlines=[]
        for i in range(reindexed_data.shape[0]):
            words=nltk.word_tokenize(reindexed_data[i])
            tagged_words_single=nltk.pos_tag(words)
            tagged_headlines.append(tagged_words_single)

        tagged_headlines = pd.DataFrame({'tags':tagged_headlines})
        tagged_headlines.to_csv('abcnews-pos-tagged.csv')
        continue
    break

print('Total number of words: ', np.sum(word_counts))
print('Mean number of words per headline: ', np.mean(word_counts))

fig,ax=plt.subplots(figsize=(18,8))
ax.hist(word_counts,bins=range(1,14),normed=1)
ax.set_title('Headline Word Lengths')
ax.set_xticks(range(1,14))
ax.set_xlabel('Number of Words')
y = mlab.normpdf( np.linspace(0,14,50), np.mean(word_counts), np.std(word_counts))
l = ax.plot(np.linspace(0,14,50), y, 'r--', linewidth=1)

##PreProcessing
small_count_vectorizer = CountVectorizer(stop_words='english', max_features=40000)
small_text_sample = reindexed_data.sample(n=5000, random_state=0).as_matrix()
print('Headline before vectorization: ', small_text_sample[123])
small_document_term_matrix = small_count_vectorizer.fit_transform(small_text_sample)
print('Headline after vectorization: \n', small_document_term_matrix[123])

n_topics = 8
from sklearn.decomposition import TruncatedSVD
lsa_model=TruncatedSVD(n_components=n_topics)
lsa_topic_matrix=lsa_model.fit_transform(small_document_term_matrix)

lsa_keys=get_keys(lsa_topic_matrix)
lsa_topic_matrix.shape

def get_keys(topic_matrix):
    '''returns an integer list of predicted topic categories for a given topic matrix'''
    