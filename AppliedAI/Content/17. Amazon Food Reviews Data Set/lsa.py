# -*- coding: utf-8 -*-
"""
Created on Wed Jul  4 06:36:16 2018

@author: Admin
"""

from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.decomposition import TruncatedSVD

dataset=["The amount of polution is increasing day by day",
         "The concrete was just great",
         "I love to see gordon Ramsay Cook",
         "Goolge is introducing new technology",
         "AI Robots are examples of great technology present today",
         "All of us were singing in the concet",
         "We have launch campaigns to stop pollution and global warming"]

dataset=[line.lower() for line in dataset]

vectorizer= TfidfVectorizer()
X=vectorizer.fit_transform(dataset)

print(X)

lsa=TruncatedSVD(n_components=4,n_iter=100)
lsa.fit(X)
lsa.components_
row1=lsa.components_[0]

term=vectorizer.get_feature_names()
concept_words={}
for i,comp in enumerate(lsa.components_):
    #term=vectorizer.get_feature_names()
    componentTerms=zip(term,comp)
    sortedTerms=sorted(componentTerms,key=lambda x:x[1], reverse=True)
    sortedTerms=sortedTerms[:10]
    print("\nConcept ",i,":")   
    for terms in sortedTerms:
        print(terms)
    concept_words["concept "+str(i)]=sortedTerms
    
componentTerms2=zip(term,lsa.components_[1])
sortedTerms=sorted(componentTerms2,key=lambda x:x[1], reverse=True)

#dataset=["pudhvi this divya varma raju srivatsavaya","taj mahal is very good"]
import  nltk
sentence_score_dict={}
for key in concept_words.keys():
    sentence_score=[]
    for sentence in dataset:
        words=nltk.word_tokenize(sentence)
        score=0
        for word in words:
            for words_with_score in concept_words[key]:
                if word == words_with_score[0]:
                    score+=words_with_score[1]
        sentence_score.append(score)
    print("\n"+key+":")
    for sentence_score1 in sentence_score:
        print(sentence_score1)
    sentence_score_dict[key]=  sentence_score 
  
    for words_with_score in concept_words[key]:
        #print(words_with_score)
        print(words_with_score[0])