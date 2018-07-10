# -*- coding: utf-8 -*-
"""
Created on Tue Jul 10 08:43:58 2018

@author: Admin
"""

import tweepy
import re
import pickle

from tweepy import OAuthHandler

## Initializing the keys
consumer_key='iramRNcUCqCGAjaLRpUZor0gd'
consumer_secret='5IwTvVJ3IPt6DywyR8Lcl7Dc6j8y8l3wTA8FhfaARI1eSQmas4'
access_token='412789020-809MoGhGeyIDig8E21XfElN0kXQei52xLYei2b9W'
access_secret='iZDY0ddHvHhxVsz41Rh2BFkAXK76NAnMvBzrJrEIhfnJu'

auth=OAuthHandler(consumer_key,consumer_secret)
auth.set_access_token(access_token,access_secret)
args=['facebook']
api=tweepy.API(auth,timeout=10)

list_tweets=[]

query=args[0]
if len(args)==1:
    for status in tweepy.Cursor(api.search,q=query+" -filter:retweets",lang='en',result_type='recent').items(100):
        list_tweets.append(status.text)
        
with open('tfidfmodel.pickle','rb') as f:
    vectorizer=pickle.load(f)

with open('classifier.pickle','rb') as f:
    clf=pickle.load(f)
    
clf.predict(vectorizer.transform(['You are a nice person man, have a good life']))

for tweet in list_tweets:
    tweet=re.sub(r"^https://t.co/[a-zA-Z0-9]*\s"," ",tweet)
    tweet=re.sub(r"\s+https://t.co/[a-zA-Z0-9]*\s"," ",tweet)
    tweet=re.sub(r"\s+https://t.co/[a-zA-Z0-9]*$"," ",tweet)
    tweet=tweet.lower()
    tweet=re.sub(r"that's","that is",tweet)
    tweet=re.sub(r"there's","there is",tweet)
    tweet=re.sub(r"what's","what is",tweet)
    tweet=re.sub(r"where's","where is",tweet)
    tweet=re.sub(r"it's","it is",tweet)
    tweet=re.sub(r"who's","who is",tweet)
    tweet=re.sub(r"i'm","i am", tweet)
    tweet=re.sub(r"she's","she is",tweet)
    tw