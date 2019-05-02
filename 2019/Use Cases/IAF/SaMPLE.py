# -*- coding: utf-8 -*-
"""
Created on Mon Apr 29 19:30:50 2019

@author: prudi
"""
import os
def nlp_model(modelpath,msge):
    if(os.path.isdir(modelpath)):
        model=modelpath
    else:
        model="en"
    logger.info( msge+" Model used :- "+model)
    return spacy.load(model)

modelpath="turner_en_model"
nlp=nlp_model(modelpath,"Test step")

import spacy
controlList=['link','button', 'field', 'dropdown' 'tab' 'menu']
control_getter = lambda token: token.lemma_ in controlList
token.set_extension('is_control', getter=control_getter,force=True)

import en_core_web_sm
nlp = en_core_web_sm.load()
import os
os.chdir(C:\Users\prudi\Anaconda3\lib\site-packages\spacy\data\en)
import spacy
spacy.load('C:\Users\prudi\Anaconda3\lib\site-packages\spacy\data\en')

doc='This is a sample text'
for word in doc:
    #if not word.isspace:
    print(word)
    print(doc[0:word.i])
    
def split_on_newlines(doc):
    start = 0
    seen_newline = False
    for word in doc:
        if seen_newline and not word.is_space:
            yield doc[start:word.i]
            start = word.i
            seen_newline = False
        elif word.text == 'and':
            seen_newline = True
    if start < len(doc):
        yield doc[start:len(doc)]
        
spacy.load('en_core_web_sm')

import spacy
from spacy.lang.en import English



from spacy.lang.en import English
from spacy.pipeline import SentenceSegmenter
def split_on_newlines(doc):
    start = 0
    seen_newline = False
    for word in doc:
        print('First print: ',word)
        if seen_newline and not word.is_space:
            print(doc[start:word.i])
            yield doc[start:word.i]
            start = word.i
            seen_newline = False
        elif word.text == 'and':
            seen_newline = True
    if start < len(doc):
        yield doc[start:len(doc)]
nlp2 = English()  # just the language with no model
sbd = SentenceSegmenter(nlp2.vocab)
nlp2.add_pipe(sbd)

nlp2('This is sample and sentences. Hello world\n !@#$%% This is prudiv')

a=nlp2.vocab
list(a)

import re
def index_remover(mod):
    indexstart=0
    modf=""
    for modi in mod:
        print(modi)
        if(indexstart==0):
            tr=re.search('^[1aAilI]+[\.\)]', modi)
            print(tr)
            if(tr):
                modf=modf+"\n"+modi
                indexstart=1
            else:
                modf=modf+" "+modi
                indexstart=0
        elif(indexstart==1):
            tr=re.search('^[0-9a-zA-Z]+[\.\)]', modi)
            if(tr):
                modf=modf+"\n"+modi
                indexstart=1
            else:
                modf=modf+" "+modi
                indexstart=0
    return modf

a=index_remover('1. This is the first step in opening a browser')
print(a)

def test_args_kwargs(arg1, arg2, arg3):
    print("arg1:", arg1)
    print("arg2:", arg2)
    print("arg3:", arg3)
args = ("two", 3, 5)
test_args_kwargs(*args)
kwargs = {"arg3": 3, "arg2": "two", "arg1": 5}
test_args_kwargs(**kwargs)
splcategory = kwargs.get('splcategory', 'Uezkdn12@RK')
splcategory
replacesplcat = kwargs.get('replacesplcat', 'Uezkdn12@RK')
dumm='This is a dummy text Uezkdn12@RK'
m = re.search(splcategory, dumm)
print(dumm)
print(dumm[:m.start()] +replacesplcat+ dumm[m.end():])