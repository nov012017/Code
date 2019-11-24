# -*- coding: utf-8 -*-
"""
Created on Tue Jul 10 10:19:24 2018

@author: Admin
"""

import bs4 as bs
import urllib.request
import re
import nltk
nltk.download('stopwords')

source=urllib.request.urlopen('https://en.wikipedia.org/wiki/Global_warming').read()

soup=bs.BeautifulSoup(source,'lxml')


text=""
for paragraph in soup.find_all('p'):
    #print(paragraph.text)
    text+=paragraph.text
    print(text)
text=re.sub(r"\[[0-9]*\]"," ",text)
text=re.sub(r'\s+',' ',text)
clean_text=text.lower()
clean_text=re.sub(r"\W"," ",clean_text) #special characters
clean_text=re.sub(r"\d"," ",clean_text)
clean_text=re.sub(r'\s+',' ', clean_text)

sentences=nltk.sent_tokenize(text)

stopwords=nltk.corpus.stopwords.words('english')
