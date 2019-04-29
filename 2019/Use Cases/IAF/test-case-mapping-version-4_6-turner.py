# -*- coding: utf-8 -*-
"""
Created on Tue Apr 23 15:21:22 2019

@author: Ramakrishna

Version upgrade :-  handling 'and' isssue by
                    1) creating a seperate raw original statement
                    2) Automation of converting Expected Results to Test Step
                    
Scripting Language:- Python
Supporting packages:- Pandas,Numpy
NLP package/library - spaCy {spaCy is an open-source library for 
                             advanced Natural Language Processing (NLP).}
                      AllenNLP {AllenNLP is a framework that makes 
                                the task of building Deep Learning models
                                for Natural Language Processing }

In spaCy, we are using the following algortims
1. NER(Named Entity Recognizer), 
2. POS(Parts-Of-Speech) tagging
3. Dependency Parsing

iN AllenNLP, we are using the following algorithms
1.SRL(Semantic Role Labelling)
"""
import datetime
starttime=datetime.datetime.now()

stepdic={}
#Importing Libraries
import os
import argparse
import sys 
ap = argparse.ArgumentParser()
ap.add_argument("-i", "--input", required=True,
 	help="input file",nargs='+')
ap.add_argument("-o", "--output", required=True,
 	help="output file",nargs='+')
args = vars(ap.parse_args())
a=""
for i in args["input"]:
    a=a+" "+i
args["input"]=a.lstrip().rstrip()
a=""
for i in args["output"]:
    a=a+" "+i
args["output"]=a.lstrip().rstrip()
if(os.path.isfile(args["input"])):
    inputfile=args["input"]
else:
    print("input file not found")
    sys.exit()
outputfile=args["output"]
if(outputfile.find(".xlsx")!=-1):
    outputlog=outputfile.replace(".xlsx",".log")
elif(outputfile.find(".xls")!=-1):
    outputlog=outputfile.replace(".xls",".log")
outputfile1='Internal/Internal-'+datetime.datetime.now().strftime('%Y_%m_%d_%H_%M')+'.xlsx'
import pandas as pd
corcorrect=pd.read_excel('test-case-mapping-correct.xlsx')
corcorrect=list(corcorrect["Event"].unique())
corcorrect.append("openBrowser")
corcorrect.append("quitBrowser")
corcorrect.append("verifyHeader")
corcorrect.append("verifyFooter")
corcorrect.append("navigateToUrl")
corcorrect.append("enterText")
corcorrect1=pd.read_excel('test-case-mapping-correct.xlsx')
corcorrect1=list(corcorrect1["Control"].unique())
#importing module 
import logging
import traceback  
#Create and configure logger 
logging.basicConfig(filename=outputlog, 
                    format='%(asctime)s [%(levelname)s] %(message)s', 
                    filemode='w')   
#Creating an object 
logger=logging.getLogger()  
#Setting the threshold of logger to DEBUG 
logger.setLevel(logging.DEBUG) 
import spacy
import re
import numpy as np
import pandas as pd
from spacy.tokens import Token
predictor = ""
writer = pd.ExcelWriter(outputfile)
writer1 = pd.ExcelWriter(outputfile1)
corpus1 = pd.ExcelWriter('test-case-mapping-corpus.xlsx')
corpus=pd.read_excel('test-case-mapping-corpus.xlsx')
corpus=corpus.fillna("omitTheValueRK")
xls1 = pd.ExcelFile('test-case-mapping-corpus.xlsx')
corpuscol=xls1.sheet_names
#Importing contents of file
xls = pd.ExcelFile(inputfile)
a=xls.sheet_names
rawDic={}
srl={}
Ashape={}
teststepindex={}
dfp2=pd.DataFrame()
def nlp_model(modelpath,msge):
    if(os.path.isdir(modelpath)):
        model=modelpath
    else:
        model="en"
    logger.info( msge+" Model used :- "+model)
    return spacy.load(model)
modelpath="turner_en_model"
nlp=nlp_model(modelpath,"Test step")
# modelpath1="C:/turner_ex_model"
# nlp3=nlp_model(modelpath1,"Expected Result model")
controlList=['link','button', 'field', 'dropdown' 'tab' 'menu']
corcorrect1=corcorrect1+controlList
control_getter = lambda token: token.lemma_ in controlList
Token.set_extension('is_control', getter=control_getter,force=True)
#corpus=dfp2
DataDict={}
from spacy.lang.en import English
from spacy.pipeline import SentenceSegmenter
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
nlp2 = English()  # just the language with no model
sbd = SentenceSegmenter(nlp2.vocab, strategy=split_on_newlines)
nlp2.add_pipe(sbd)
# def actexpres(dic,teststep,pagedic,pagei):
#     if(dic["Control text"].lower().find("header")!=-1 or dic["Control text"].lower().find("footer")!=-1):
#         return teststep,pagedic,pagei
#     dic["Actexpres"]=dic["Actexpres"].lstrip().rstrip()
#     dic["Actexpres"]=re.sub(',$','',re.sub('^,','',dic["Actexpres"]))
#     doc2=nlp3(dic["Actexpres"])
#     token=doc2[1]
#     while token.i < len(doc2):
#         asdqwe=0
#         if(token.text=="-"):
#             span = doc2[token.i-1:token.i+1]
#             span.merge()
#             asdqwe=1
#         elif(doc2[token.i-1].text[-1]=="-"):
#             span = doc2[token.i-1:token.i+1]
#             span.merge()
#             asdqwe=1
#         if(token.i < len(doc2)-1):
#             if(asdqwe==0):
#                 token=doc2[token.i+1]
#             else:
#                 token=doc2[token.i]
#         else:
#             break
#     posscontrollist=""
#     posscontrollist123=[]
#     dic4={'Acceptance':'Pending','Original statement':'Got from Expected Results','Control text':'','Event':'','Data':'','Control':''}
#     for token in doc2:
#         if(token.text==","):
#             posscontrollist=posscontrollist+' '+"breRkak"
#             posscontrollist123.append(dic4)
#             dic4={'Acceptance':'Pending','Original statement':'Got from Expected Results','Control text':'','Event':'','Data':'','Control':''}
#         elif(token.like_url==True):
#             dic4['Data']=dic4['Data']+ ' , '+token.text
#             if(token.like_url==True and dic4['Control']==''):
#                 dic4['Control']='toUrl'
#         elif (token.ent_type_=="controlText" ):
#             posscontrollist=posscontrollist+' '+token.text
#             dic4["Control text"]=dic4["Control text"]+" "+token.text
#         elif (token.pos_=='PROPN' and token.like_url!=True):
#             posscontrollist=posscontrollist+' '+token.text
#             dic4["Control text"]=dic4["Control text"]+" "+token.text
#         elif(token._.is_control==True):
#             if(dic4["Control"]==''):
#                 dic4["Control"]=token.text
#     controlTextlist=dic['Control text'].split(" ")
#     posscontrollist=posscontrollist.split("breRkak")
#     qwqwsq=0
#     final_list = [] 
#     for num in posscontrollist:
#         if (num not in final_list):
#             if(num!=""):
#                 final_list.append(num)
#     posscontrollist=final_list
#     for pci in posscontrollist:
#         if(qwqwsq==1):
#             break
#         for cti in controlTextlist:
#             if(pci.find(cti)!=-1):
#                 staq=dic["Actexpres"].find(cti)+len(cti)
#                 main=dic["Actexpres"]
#                 dic["Actexpres"]=dic["Actexpres"][staq:].replace(" breRKak",",")
#                 if(main.lower().find("section")!=-1 and dic["Actexpres"][staq:]==-1):
#                     dic["Actexpres"]=dic["Actexpres"]+' section'
#                 qwqwsq=1
#                 posscontrollist=posscontrollist[:posscontrollist.index(pci)]
#                 break
#     # print(len(re.findall(r"breRKak",(" breRKak ".join(posscontrollist)))))
#     for pci in posscontrollist:
#         dic4={'NER Repository':'','repository':'','Acceptance':'Pending','Original statement':'Got from Expected Results','Control text':'','Event':'verify','Data':'','Control':'validate','Test Case ID':a[j]+"_TC_"+str(testcasevalue).replace("TC_",""),"Test Step ID":a[j]+"_TC_"+str(testcasevalue).replace("TC_","")+"_"+str("{:03d}".format(teststep))}
#         teststep+=1
#         if(pci.lstrip().rstrip()!=""):
#             dic4["Control text"]=pci.lstrip().rstrip()
#             for poss123 in posscontrollist123:
#                 qaqawse=0
#                 if(poss123['Control text'].lstrip().rstrip()==dic4["Control text"]):
                    
#                     dic4["Data"]=re.sub("^ ,","",poss123["Data"])
#                     dic4["Control"]=poss123["Control"]
#                     dic4["Event"]=poss123["Event"]
#                     qaqawse=1
#                 if(dic4["Event"]==''):
#                     dic4["Event"]="verify"
#                 if(qaqawse==1):
#                     break
#             if(qwqwsq==1):
#                 dic4["Actexpres"]=dic["Actexpres"].replace(" breRKak",",")
#             if(dic["Actexpres"].find("section")!=-1):
#                 dic4["Control"]="link"
#             dic4["Actexpreso"]=dic["Actexpreso"]
#             if(pagedic[pagei]["Control text"]!=dic4["Control text"]):
#                 pagedic[pagei+1]=dic4
#                 pagei+=1
#     print(posscontrollist123)
#     return teststep,pagedic,pagei
def andSpliter(sent):
    doc2=nlp2(sent.lower())
    starttokentext1=0
    event2=''
    for token in doc2:
        lemmas=token.lemma_
        if(starttokentext1>0):
            starttokentext1=Xa.iloc[i][col[0]].lower().find(token.text,starttokentext1-1)
        else:
            starttokentext1=Xa.iloc[i][col[0]].lower().find(token.text)
        # print(token.ent_type_,"\t",token.text,'\t',token.pos_,'\t',token.dep_,'\t',token.like_url,'\t',lemmas.lower())
        if(token.ent_type_!=""):
            if(event2=='' and token.ent_type_=="event" and token.is_punct== False and token.is_digit== False):
                if(lemmas!='be'):
                    event2=token.text
        else:
            if (((token.pos_=='ADJ' and token.dep_!='compound') or (token.pos_=='VERB' and token.dep_!='amod')) and (token.is_digit==False and token.is_punct==False)):
                if(event2==''):
                    if(lemmas!='be'):
                        event2=token.text
    return event2
def index_remover(mod):
    indexstart=0
    modf=""
    for modi in mod:
        if(indexstart==0):
            tr=re.search('^[1aAilI]+[\.\)]', modi)
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
def splitDataFrameList(df,target_column,separator,**kwargs):
    df.fillna("TestcaseNan")
    splcategory = kwargs.get('splcategory', 'Uezkdn12@RK')
    replacesplcat = kwargs.get('replacesplcat', 'Uezkdn12@RK')
    new_rows = []
    def splitListToRows(row,row_accumulator,target_column,separator,splcategory,replacesplcat):
        row[target_column]=str(row[target_column]).rstrip().lstrip()
        if splcategory!='Uezkdn12@RK' and replacesplcat!='Uezkdn12@RK':
            dumm =  row[target_column]
            m = re.search(splcategory, dumm)
            if(m!=None):
                row[target_column]=dumm[:m.start()] +replacesplcat+ dumm[m.end():]
        split_row = row[target_column].lstrip().rstrip().split(separator)
        for s in split_row:
            new_row = row.to_dict()
            new_row[target_column] = s
            row_accumulator.append(new_row)   
    df.apply(splitListToRows,axis=1,args = (new_rows,target_column,separator,splcategory,replacesplcat))
    new_df = pd.DataFrame(new_rows)
    return new_df
logger.info("List of sheet"+str(a))
sttime=datetime.datetime.now()
try:
    for j in range(len(a)):
        # Importing the dataset
        print(a[j])
        logger.info('{:=^40}'.format(""))
        logger.info("Sheet "+str(j)+" is "+a[j])
        Xa=pd.read_excel(inputfile,sheet_name=a[j])
        aa=Xa.shape
        if(aa[0]==0 and aa[1]==0):
            print("Empty page")
            logger.info("Empty page") 
            continue
        Xa=Xa.dropna(how='all', axis=1)
        Xa=Xa.dropna(how='all', axis=0)
        Xa.reset_index(drop=True,inplace=True)
        col=Xa.columns.values.tolist()
        Xa.loc[-1]=Xa.columns.values.tolist()
        Xa.index=Xa.index+1
        Xa=Xa.sort_index()
        corpus=corpus.fillna("")
        rawDic[a[j]]=Xa
        breakpoint=""
        # Extracting the table
        Xtc=rawDic[a[j]]
        titlelst=['TC','Test case','Testcase']
        Xtcbreak=0
        for colnum in range(Xtc.shape[1]):
            for rownum in range(Xtc.shape[0]):
                for titlename in titlelst:
                    if( Xtcbreak==0 and str(Xtc.iloc[rownum][col[colnum]]).lower().find(titlename.lower())!=-1):
                        teststepindex[a[j]+"Test case"]=[rownum,colnum]
                        Xtcbreak+=1
        if(Xtcbreak==1):
            df1,df2 = np.split(Xa, [teststepindex[a[j]+"Test case"][0]], axis=0)
            df1,df=np.split(df2, [teststepindex[a[j]+"Test case"][1]], axis=1)
            df,df1=np.split(df, [1], axis=1)
            df=df.reset_index(drop =True)
            cold=df.columns.values.tolist()
            if(df.iloc[0][cold[0]]==cold[0]):
                df.columns = df.iloc[0]
                df=df.drop(0, axis=0)
                df=df.reset_index(drop =True)
            print("Test case column found in "+a[j])
            logger.info("Test case column found in "+a[j])
            Xtc=df
            Xtc=Xtc.fillna("TestcaseNan")
            coltc=Xtc.columns.values.tolist()
            Xtc[coltc[0]]=Xtc[coltc[0]].astype('str')
        titlelst=['Step Details','Test step','Test steps']
        Xa=rawDic[a[j]]
        Xabreak=0
        for titlename in titlelst:
            for colnum in range(Xa.shape[1]):
                for rownum in range(Xa.shape[0]):
                    if(Xabreak==0 and str(Xa.iloc[rownum][col[colnum]]).lower().find(titlename.lower())!=-1):
                        teststepindex[a[j]]=[rownum,colnum]
                        Xabreak=1
                        if(Xtcbreak==1):
                            if(rownum!=teststepindex[a[j]+"Test case"][0]):
                                Xtcbreak=0
                                logger.info("Test case column found in "+a[j]+ " has a mismatch with Test step column")
        if(Xabreak==1):
            df1,df2 = np.split(Xa, [teststepindex[a[j]][0]], axis=0)
            df1,df=np.split(df2, [teststepindex[a[j]][1]], axis=1)
            df,df1=np.split(df, [1], axis=1)
            df=df.reset_index(drop =True)
            df.columns = df.iloc[0]
            df=df.drop(0, axis=0)
            df=df.reset_index(drop =True)
            print("Test steps column found in "+a[j])
            logger.info("Test steps column found in "+a[j])
            Xa=df
        else:
            print("Unable to find test steps")
            logger.info("Unable to find test steps")
            continue
        Xc= rawDic[a[j]]
        colc=Xc.columns.values.tolist()
        seperatorc=0
        Xcbreak=0
        titlelst=["Expected Result","Expected"]
        for colnum in range(Xc.shape[1]):
            for rownum in range(Xc.shape[0]):
                for titlename in titlelst:
                    if(Xcbreak==0 and str(Xc.iloc[rownum][col[colnum]]).lower().rstrip().lstrip().find(titlename.lower())!=-1):
                        teststepindex[a[j]+"Expected Results"]=[rownum,colnum]
                        Xcbreak=1
                    elif(Xcbreak==1 and (teststepindex[a[j]+"Expected Results"][0]!=teststepindex[a[j]][0] or teststepindex[a[j]+"Expected Results"][1]==teststepindex[a[j]][1])):
                        Xcbreak=0
        if(Xcbreak==1):
            df1,df2 = np.split(Xc, [teststepindex[a[j]+"Expected Results"][0]], axis=0)
            df1,df=np.split(df2, [teststepindex[a[j]+"Expected Results"][1]], axis=1)
            df,df1=np.split(df, [1], axis=1)
            df=df.reset_index(drop =True)
            df.columns = df.iloc[0]
            df=df.drop(0, axis=0)
            df=df.reset_index(drop =True)
            print("Expected Results column found in "+a[j])
            logger.info("Expected Results column found in "+a[j])
            Xc=df
            colc=Xc.columns.values.tolist()
            Xcori=Xc
        col=Xa.columns.values.tolist()
        logger.info("Ensuring no mismatch of index with all the columns of "+a[j])
        # index checking
        if(len(col)==1):
            X=pd.DataFrame()
            Xashape=Xa.shape
            Ashape[a[j]+"Xa"]=Xashape
            Xindex=Xa.index.tolist()
            for i in Xindex:
                if(str(Xa.iloc[i][col[0]])=='nan'):
                    Xa.at[i,col[0]]=""
                if(str(Xa.iloc[i][col[0]]).lower().find("\n ".lower())!=-1):
                    Xa.at[i,col[0]]=Xa.iloc[i][col[0]].replace("\n ","\n")
                if(str(Xa.iloc[i][col[0]]).lower().find(" \n".lower())!=-1):
                    Xa.at[i,col[0]]=Xa.iloc[i][col[0]].replace(" \n","\n")
                Xa.at[i,col[0]]=Xa.iloc[i][col[0]].replace("   ","\n")
                Xa.at[i,col[0]]=Xa.iloc[i][col[0]].replace("\n\n","\n")
            Xindex=Xa.index.tolist()
            for i in Xindex:
                mod=Xa.iloc[i][col[0]].split("\n")
                modf=index_remover(mod)
                Xa.at[i,col[0]]=modf.lstrip().rstrip()
            Xindex=Xa.index.tolist()
            DDi=1
            Xao=Xa
            colao=Xao.columns.values.tolist()
            coluw={}
            for i in colao:
                coluw[i]=i+"ori"
            Xao=Xao.rename(coluw,axis="columns")
            colao=Xao.columns.values.tolist()
            X=pd.concat([X,Xao],axis=1)
            for i in Xindex:
                startData=0
                while True:
                    if(str(Xa.iloc[i][col[0]]).find('("')!=-1):
                        startData=str(Xa.iloc[i][col[0]]).find('("')
                        endData=str(Xa.iloc[i][col[0]]).find('")',startData)+1
                        DataDict["DataRKDict"+str(DDi)]=str(Xa.iloc[i][col[0]])[startData:endData+1]
                        Xa.at[i,col[0]]=str(Xa.iloc[i][col[0]])[:startData]+"DataRKDict"+str(DDi)+" "+str(Xa.iloc[i][col[0]])[endData+1:]
                        Xa.at[i,col[0]]=Xa.iloc[i][col[0]].replace("\nDataRKDict"," DataRKDict")
                        DDi+=1
                    else:
                        break
            X=pd.concat([X,Xa],axis=1)
            
            if(Xcbreak==1):
                Xcshape=Xc.shape
                Ashape[a[j]+"Xc"]=Xcshape
                if(Xashape[0]>Xcshape[0]):
                    diff=Xashape[0]-Xcshape[0]
                    for ida in range(diff):
                        Xc=Xc.append({colc[0]: ""},ignore_index=True)
                X=pd.concat([X,Xc],axis=1)
            if(Xtcbreak==1):            
                Xtcshape=Xtc.shape                     
                Ashape[a[j]+"Xtc"]=Xtcshape
                if(Xashape[0]>Xtcshape[0]):
                    diff=Xashape[0]-Xtcshape[0]
                    for ida in range(diff):
                        Xtc=Xtc.append({coltc[0]: "TestcaseNan"},ignore_index=True)
                X=pd.concat([Xtc,X],axis=1)
            
            if(Xtcbreak==1 and Xcbreak==1):
                X=X.dropna(thresh=2)
            X=X.reset_index(drop =True)
            X=splitDataFrameList(df=X,
                                 target_column=col[0],
                                 separator="\n",
                                 splcategory=r'\nhttp',
                                 replacesplcat=' http')
            droplist=list()
            Xindex=X.index.tolist()
            for i in Xindex:
                if(X.iloc[i][col[0]]==""):
                    droplist.append(i)
            X=X.drop(droplist, axis=0)
            X.reset_index(drop=True,inplace=True)
            Xindex=X.index.tolist()
            repeatlist=list()
            for i in Xindex:
                if(Xtcbreak==1):
                    if(i>0):
                        if(str(X.iloc[i-1][coltc[0]])!="TestcaseNan"):
                            if(str(X.iloc[i][coltc[0]])==str(X.iloc[i-1][coltc[0]]) ):
                                repeatlist.append(i)              
                            else:
                                for ri in repeatlist:
                                    X.at[ri,coltc[0]]="TestcaseNan"
                                repeatlist=list()
            if(len(repeatlist)>0):
                for ri in repeatlist:
                    X.at[ri,coltc[0]]="TestcaseNan"
            Xindex.reverse()
            repeatlist=list()
            repeatlist1=list()
            for i in Xindex:
                if(str(X.iloc[i][colao[0]])==str(X.iloc[i-1][colao[0]])):
                    repeatlist1.append(i-1)
                else:
                    for ri in repeatlist1:
                        X.at[ri,colao[0]]=""
                    repeatlist1=list()
                if(Xcbreak==1):
                    if(str(X.iloc[i][colc[0]])==str(X.iloc[i-1][colc[0]])):
                        repeatlist.append(i-1)
                    else:
                        for ri in repeatlist:
                            X.at[ri,colc[0]]=""
                        repeatlist=list()
            Xa=X[col[0]].to_frame()
            Xao=X[colao[0]].to_frame()
            Xao.columns=Xa.columns
            if(Xtcbreak==1):
                Xtc=X[coltc[0]].to_frame()
            if(Xcbreak==1):
                Xc=X[colc[0]].to_frame()
        
        if(Xtcbreak==0):
            Xtc=pd.DataFrame()
            Xindex=Xa.index.tolist()
            col=Xa.columns.values.tolist()
            for Xi in Xindex:
                if(Xa.iloc[Xi][col[0]].lstrip().rstrip()==""):
                    Xa.at[Xi,col[0]]=""
                if(str(Xa.iloc[Xi][col[0]]).lower().find("Test 1.".lower())==-1):
                    
                    Xtc=Xtc.append({"Testcase": "TestcaseNan"},ignore_index=True)
                else:
                    
                    Xtc=Xtc.append({"Testcase":str(Xa.iloc[Xi][col[0]])},
                                    ignore_index=True)
                if(Xa.iloc[Xi][col[0]]==Xtc.iloc[Xi]["Testcase"]):
                    Xa.at[Xi,col[0]]=Xa.iloc[Xi+1][col[0]]
                    Xa.at[Xi+1,col[0]]=""
            X=pd.concat([Xtc,Xa],axis=1)
            droplist=list()
            Xindex=X.index.tolist()
            for i in Xindex:
                if(Xtc.iloc[i]["Testcase"]=="TestcaseNan" and Xa.iloc[i][col[0]]==""):
                    droplist.append(i)
            X=X.drop(droplist, axis=0)
            X.reset_index(drop=True,inplace=True)
            Xindex=X.index.tolist()
            Xtcbreak=1
            Xa=X[col[0]].to_frame()
            if(Xtcbreak==1):
                Xtc=X["Testcase"].to_frame()
                coltc=Xtc.columns.values.tolist()
        pagedic={}
        rawpagedic={}
        teststep=1
        testcasevalue=""
        teststep1=0
        pagei=0
        l=0
        coltc=Xtc.columns.values.tolist()
        indexstart=0
        logger.info("NLP implementation in "+a[j])
        while l < int(len(Xa.index)):
            Xa.iloc[l][col[0]]=Xa.iloc[l][col[0]].lstrip().rstrip()
            Xa.iloc[l][col[0]]=Xa.iloc[l][col[0]].replace(' & ',' and the ')
            Xa.iloc[l][col[0]]=Xa.iloc[l][col[0]].replace(' then ',' ')
            Xa.iloc[l][col[0]]=Xa.iloc[l][col[0]].replace('http',' http')
            Xa.iloc[l][col[0]]=Xa.iloc[l][col[0]].replace('  ',' ')
            if(Xa.iloc[l][col[0]].lower().find("verify")!=-1 and 
               Xa.iloc[l][col[0]].lower().find(" or not")!=-1):
                Xa.iloc[l][col[0]]=Xa.iloc[l][col[0]].replace("or not","")
            if(Xa.iloc[l][col[0]].lower().find("verify")!=-1 and 
               Xa.iloc[l][col[0]].lower().find(" whether")!=-1):
                Xa.iloc[l][col[0]]=Xa.iloc[l][col[0]].replace(" whether","")
            mod=Xa.iloc[l][col[0]]
            modo=Xao.iloc[l][col[0]]
            if(Xcbreak==1):
                modc=Xc.iloc[l][colc[0]]
            if(Xtcbreak==1):
                modtc=Xtc.iloc[l][coltc[0]]
            if(mod.lower().find('login to')!=-1):
                if(mod.lower().find('website')==-1 and mod.lower().find('url')==-1 and mod.lower().find('http')==-1):
                    mod="Enter the login credentials"
            if(mod.lower().find('login credential')!=-1 or mod.lower().find('logincredential')!=-1):
                mod=mod.lower().replace(' credential','credential')
                mod=mod.lower().replace('credentials','credential')
                mod=mod.lower().replace('logincredential','username and password')
            if(mod.lower().find('user id')!=-1 or mod.lower().find('userid')!=-1):
                mod=mod.lower().replace(' id','id')
                Xa.iloc[l][col[0]]=mod
            
            # handling "Repeat Steps"
            repeatFlag=0
            if(mod.lower().find("repeat ")!=-1):
                repeatFlag=1
                steps=[int(s) for s in mod.split() if s.isdigit()]
                dic={'NER Repository':'','repository':'','Acceptance':'Pending','Original statement':'','Control text':'','Event':'','Data':'','Control':'','Test Case ID':a[j]+"_TC_"+str(testcasevalue).replace("TC_",""),"Test Step ID":a[j]+"_TC_"+str(testcasevalue).replace("TC_","")+"_"+str("{:03d}".format(teststep))}
                for stepi in steps:
                    for repi in pagedic.keys():
                        if(pagedic[repi]["Test Step ID"]==(a[j]+"_TC_"+str(testcasevalue).replace("TC_","")+"_"+str("{:03d}".format(int(stepi))))):
                            stepdic={}
                            for pagekeysi in pagedic[repi].keys():
                                stepdic[pagekeysi]=pagedic[repi][pagekeysi]
                            stepdic["Test Step ID"]=a[j]+"_TC_"+str(testcasevalue).replace("TC_","")+"_"+str("{:03d}".format(int(teststep)))
                            teststep+=1
                            tot=Xc.shape
                            if(Xcbreak==1 and l<=(tot[0]-1)):
                                stepdic["Expected Results"]=Xc.iloc[l][colc[0]]
                            break
                    if(str(type(stepdic)).find("str")==-1):
                        pagedic[pagei+1]=stepdic
                        pagedic[repi]["Test Step ID"]=a[j]+"_TC_"+str(testcasevalue).replace("TC_","")+"_"+str("{:03d}".format(int(stepi)))
                        pagei+=1
                l+=1
            fstX=1
            
            if(repeatFlag==0):
                if(mod.lower().find(' and ')!=-1):
                    andthenflag=0
                    if(re.search('^And then, ', mod)):
                        mod=re.sub('^And then, ',"", mod)
                        andthenflag=1
                    else:
                        andthenflag=0
                    doc = nlp(mod)
                    df1,df2 = np.split(Xa, [l], axis=0)
                    df7,df8 = np.split(Xao, [l], axis=0)
                    if(l>Xa.index.tolist()[0]):
                        fstX=0
                        if(Xcbreak==1):
                            df3,df4 = np.split(Xc, [l], axis=0)
                        if(Xtcbreak==1):
                            df5,df6 = np.split(Xtc, [l], axis=0)
                    else:
                        fstX=1
                        if(Xcbreak==1):
                            df3,df4 = np.split(Xc, [l+1], axis=0)
                        if(Xtcbreak==1):
                            df5,df6 = np.split(Xtc, [l+1], axis=0)
                    andi={'flag':0,'value':0}
                    ieew=0
                    tokenl=[token.text for token in doc]
                    for token in doc:
                        if (token.text.lower()=="and" and andi['flag']==0 and doc[token.i].text.lower()!="then"):
                           andi['value']=token.i
                           andi['flag']=1
                           break
                    if(andi['flag']==1):
                        mod=" ".join(tokenl[0:andi["value"]])
                    if(andthenflag==1):
                        mod="And then, "+mod
                    mod1=" ".join(tokenl[andi["value"]+1:])
                    mod=mod.lstrip().rstrip()
                    extra=pd.DataFrame([mod], columns=col,index=[l+1])
                    df1=pd.concat([df1,extra])
                    extrao=pd.DataFrame([''], columns=col,index=[l+1])
                    df7=pd.concat([df7,extrao])
                    if(fstX==0):
                        if(Xcbreak==1):
                            extrac=pd.DataFrame([''], columns=colc,index=[l+1])
                            df3=pd.concat([df3,extrac])
                        if(Xtcbreak==1):
                            extratc=pd.DataFrame(['TestcaseNan'], columns=coltc,index=[l+1])
                            df5=pd.concat([df5,extratc])
                    else:
                        if(Xcbreak==1):
                            df4.loc[df4.index.tolist()[0]-1]=[""]
                            df4=df4.sort_index()
                        if(Xtcbreak==1):
                            df6.loc[df6.index.tolist()[0]-1]=["TestcaseNan"]
                            df6=df6.sort_index()
                    df2.index=range(l+2,len(df2)+l+2)
                    if(fstX==0):                    
                        if(Xcbreak==1):
                            df4.index=range(l+2,len(df4)+l+2)
                        if(Xtcbreak==1):
                            df6.index=range(l+2,len(df6)+l+2)
                    if(mod1.find("And then,")==-1 and mod1.lstrip().rstrip()!=""):
                        mod1="And then, "+mod1
                    df2.iloc[0][col[0]]=mod1
                    Xa=pd.concat([df1,df2])
                    df8.iloc[0][col[0]]=modo
                    Xao=pd.concat([df7,df8])
                    if(Xcbreak==1):
                        df4.iloc[0][colc[0]]=modc
                        Xc=pd.concat([df3,df4])
                    if(Xtcbreak==1):
                        df6.iloc[0][coltc[0]]=modtc
                        Xtc=pd.concat([df5,df6])
                    if(fstX==1):
                        if(Xcbreak==1):
                            Xc=Xc.reset_index(drop =True)
                            if(Xc.iloc[l][colc[0]]==Xc.iloc[l+1][colc[0]]):
                                Xc.iloc[l][colc[0]]=""
                        if(Xtcbreak==1):
                            Xtc=Xtc.reset_index(drop =True)
                            if(Xtc.iloc[l][coltc[0]]==Xtc.iloc[l+1][coltc[0]]):
                                Xtc.iloc[l+1][coltc[0]]="TestcaseNan"
                if(mod.lower().find("text ")!=-1):
                    mod=mod.replace('text ','text')
                    Xa.iloc[l][col[0]]=mod
                i=l        
                l+=1
                if(Xtcbreak==1):
                    if(teststep1==0):
                        testcasevalue="TC_01"
                        logger.info("First Test case to be processed")
                        teststep=1
                        teststep1=1
                    else:
                        if(Xtc.iloc[i][coltc[0]]!="TestcaseNan"):
                            dic={'NER Repository':'','repository':'','Acceptance':'Pending','Original statement':'Quit the Browser','Control text':'','Event':'quitBrowser','Data':'','Control':'','Test Case ID':a[j]+"_TC_"+str(testcasevalue).replace("TC_",""),"Test Step ID":a[j]+"_TC_"+str(testcasevalue).replace("TC_","")+"_"+str("{:03d}".format(teststep)),'Expected Results':'Quit the Browser'}
                            pagedic[pagei+1]=dic
                            pagei+=1
                            Xtc.iloc[i][col[0]] = str(Xtc.iloc[i][coltc[0]])
                            testcasevalue=Xtc.iloc[i][coltc[0]]
                            teststep=1
                            logger.info("Testcase value "+testcasevalue+" is to be processed")
                else:
                    if(teststep1==0):
                        testcasevalue="TC_01"
                        teststep=1
                        teststep1=1
                dic={'NER Repository':'','repository':'','Acceptance':'Pending','Original statement':'','Control text':'','Event':'','Data':'','Control':'','Test Case ID':a[j]+"_TC_"+str(testcasevalue).replace("TC_",""),"Test Step ID":a[j]+"_TC_"+str(testcasevalue).replace("TC_","")+"_"+str("{:03d}".format(teststep))}
                teststep+=1
                if(str(Xa.iloc[i][col[0]]).lower().replace("nan","").replace('"',"").lstrip().rstrip()==""):
                    continue
                Xa.iloc[i][col[0]] = re.sub('^i\.e\.','That is', Xa.iloc[i][col[0]])
                if(indexstart==0):
                    tr=re.search('^[1aAilI]+[\.\)]', Xa.iloc[i][col[0]])
                    if(tr):
                        Xa.iloc[i][col[0]] = re.sub('^[1aAilI]+[\.\)]','', Xa.iloc[i][col[0]])
                        indexstart=1
                    else:
                        indexstart=0
                if(indexstart==1):
                    Xa.iloc[i][col[0]] = re.sub('^[0-9a-zA-Z]+[\.\)]','', Xa.iloc[i][col[0]])
                else:
                    indexstart=0
                
                if(Xa.iloc[i][col[0]].lower().find("login")!=-1 and Xa.iloc[i][col[0]].lower().find("page")!=-1):
                    Xa.iloc[i][col[0]]=Xa.iloc[i][col[0]]+" url"
                #SRL implementation
                if(Xa.iloc[i][col[0]].lower().find(" from ")!=-1 or Xa.iloc[i][col[0]].lower().find(" when ")!=-1):
                    if(predictor==""):
                        logger.info("\n"+'{:=^100}'.format("Ignore"))
                        from allennlp.predictors.predictor import Predictor
                        predictor = Predictor.from_path("https://s3-us-west-2.amazonaws.com/allennlp/models/srl-model-2018.05.25.tar.gz")
                        logger.info("\n"+'{:=^90}'.format("End Ignore"))
                    srl[a[j]+" "+str(i)]=predictor.predict(sentence=Xa.iloc[i][col[0]])
                    if(len(srl[a[j]+" "+str(i)]["verbs"])==1):
                        srl[a[j]+" "+str(i)]=srl[a[j]+" "+str(i)]["verbs"][0]["description"].split("] ")
                        srlArg=[]
                        for k in range(len(srl[a[j]+" "+str(i)])):
                            if((srl[a[j]+" "+str(i)][k].find("[V:")==-1 and srl[a[j]+" "+str(i)][k].find("[ARG")==-1 ) and (srl[a[j]+" "+str(i)][k-1].find("[V:")!=-1 or srl[a[j]+" "+str(i)][k-1].find("[ARG")!=-1 ) and k>0 and srl[a[j]+" "+str(i)][k].lstrip().rstrip()!=""):
                                srl[a[j]+" "+str(i)][k-1]=srl[a[j]+" "+str(i)][k-1]+srl[a[j]+" "+str(i)][k]
                                srl[a[j]+" "+str(i)][k]=""
                            if(srl[a[j]+" "+str(i)][k].find("[V:")!=-1):
                                srlVerb=srl[a[j]+" "+str(i)][k].replace("[V:","")
                                srl[a[j]+" "+str(i)][k]=re.sub('\[V:','', srl[a[j]+" "+str(i)][k])
                            elif(srl[a[j]+" "+str(i)][k].find("[ARG")!=-1 and srl[a[j]+" "+str(i)][k].find("[ARG-")==-1):
                                srl[a[j]+" "+str(i)][k]=re.sub('\[ARG.*:','', srl[a[j]+" "+str(i)][k])
                                srlArg.append(k)
                        if(len(srlArg)==2):
                            srlmod1=[]
                            for srli in range(1,-1,-1):
                                srlmod1.append(srlVerb+" "+srl[a[j]+" "+str(i)][srlArg[srli]])
                            df1,df2 = np.split(Xa, [i], axis=0)
                            df7,df8 = np.split(Xao, [i], axis=0)
                            if(Xcbreak==1):
                                df3,df4 = np.split(Xc, [i], axis=0)
                            if(Xtcbreak==1):
                                df5,df6 = np.split(Xtc, [i], axis=0)
                            for srlmodi in range(len(srlmod1)-1):
                                mod=srlmod1[srlmodi]
                                mod=mod.lstrip().rstrip()
                                if(mod.find(" ")==-1):
                                    mod=dic["Event"]+" "+mod
                                extra=pd.DataFrame([mod], columns=col,index=[i+1])
                                df1=pd.concat([df1,extra])
                                extrao=pd.DataFrame(['  '], columns=col,index=[i+1])
                                df7=pd.concat([df7,extrao])
                                if(Xcbreak==1):
                                    extrac=pd.DataFrame([''], columns=colc,index=[i+1])
                                    df3=pd.concat([df3,extrac])
                                if(Xtcbreak==1):
                                    extratc=pd.DataFrame(['TestcaseNan'], columns=coltc,index=[i+1])
                                    df5=pd.concat([df5,extratc])
                            df2.index=range(i+2,len(df2)+i+2)
                            df8.index=range(i+2,len(df8)+i+2)
                            if(Xcbreak==1):
                                df4.index=range(i+2,len(df4)+i+2)
                            if(Xtcbreak==1):
                                df6.index=range(i+2,len(df6)+i+2)
                            mod1=srlmod1[len(srlmod1)-1]
                            df2.iloc[0][col[0]]=mod1
                            Xa=pd.concat([df1,df2])
                            df2.iloc[0][col[0]]=modo
                            Xao=pd.concat([df7,df8])
                            if(Xcbreak==1):
                                df4.iloc[0][colc[0]]=modc
                                Xc=pd.concat([df3,df4])
                            if(Xtcbreak==1):
                                df6.iloc[0][colc[0]]=modtc
                                Xtc=pd.concat([df5,df6])
                if(teststep==2):
                    if(Xa.iloc[i][col[0]].lower().find("browser")==-1 or Xa.iloc[i][col[0]].lower().find("open")==-1):
                        # print(teststep-1,i)
                        dic={'NER Repository':'','repository':'','Acceptance':'Pending','Original statement':'Open the Browser','Control text':'','Event':'openBrowser','Data':'','Control':'','Test Case ID':a[j]+"_TC_"+str(testcasevalue).replace("TC_",""),"Test Step ID":a[j]+"_TC_"+str(testcasevalue).replace("TC_","")+"_"+str("{:03d}".format(teststep-1)),'Expected Results':'Open the Browser'}
                        pagedic[pagei+1]=dic
                        pagei+=1
                        dic={'NER Repository':'','repository':'','Acceptance':'Pending','Original statement':'','Control text':'','Event':'','Data':'','Control':'','Test Case ID':a[j]+"_TC_"+str(testcasevalue).replace("TC_",""),"Test Step ID":a[j]+"_TC_"+str(testcasevalue).replace("TC_","")+"_"+str("{:03d}".format(teststep)),'Expected Results':''}
                        teststep+=1
                #check if the staement is in corrected sentence or not 
                doc = nlp(Xa.iloc[i][col[0]].lower())
                if(str(Xa.iloc[i][col[0]]).find("DataRKDict")!=-1):
                    startData=str(Xa.iloc[i][col[0]]).find("DataRKDict")
                    endData=str(Xa.iloc[i][col[0]]).find(" ",startData)
                    DataDictkey=str(Xa.iloc[i][col[0]])[startData:endData]
                    if DataDictkey in DataDict.keys():
                        X.iloc[i][col[0]]=str(Xa.iloc[i][col[0]])[:startData]+" "+DataDict[DataDictkey]+" "+str(X.iloc[i][col[0]])[endData:]
                dic['Original statement']=Xao.iloc[i][col[0]].lstrip().rstrip()
                if(dic['Original statement']!=''):
                    oristatement=dic['Original statement']
                else:
                    jio=0
                    while True:
                        if(Xao.iloc[i+jio][col[0]].lstrip().rstrip()!=''):
                            oristatement=Xao.iloc[i+jio][col[0]].lstrip().rstrip()
                            break
                        else:
                            jio+=1
                startqoute=0
                startqouteindex=0
                token=doc[0]
                if(Xa.iloc[i][col[0]].lstrip().rstrip().find(' ')!=-1):
                    while token.i < len(doc):
                        if(token.is_quote):
                            if(startqoute==0):
                                startqoute=1
                                startqouteindex=token.i
                            else:
                                span = doc[startqouteindex+1:token.i]
                                span.merge()
                                startqoute=0
                        if(token.i < len(doc)-1):
                            token=doc[token.i+1]
                        else:
                            break
                    # print(Xa.iloc[i][col[0]])
                    logger.info('{:-^40}'.format(""))
                    logger.info("Test Step "+str(teststep)+" is \"" +Xa.iloc[i][col[0]]+"\"")
                    logger.info('ner\ttoken text\tlemmatised\tfilled in')
                    starttokentext1=0
                    starttokentext2=0
                    for token in doc:
                        logger.info(str(token.ent_type_) + "\t"+str(token.text) +'\t')
                        lemmas=token.lemma_
                        if(starttokentext1>0):
                            starttokentext2=starttokentext1
                            starttokentext1=Xa.iloc[i][col[0]].lower().find(token.text,starttokentext1-1)
                        else:
                            starttokentext1=Xa.iloc[i][col[0]].lower().find(token.text)
                        tokenword=Xa.iloc[i][col[0]][starttokentext1:(starttokentext1+len(token.text))]
                        
                        if(str(token.text).find("datarkdict".lower())!=-1):
                            DataDictkey=token.text
                            DataDictkey=DataDictkey.replace("rk","RK")
                            DataDictkey=DataDictkey.replace("d","D")
                            if DataDictkey in DataDict.keys():
                                dic["Data"]=DataDict[DataDictkey]
                        elif(lemmas=="page" and (doc[token.i-1].dep_=="det" or doc[token.i-1].dep_=="prep")):
                            logger.info(str(token.ent_type_) +'\t'+str(lemmas.lower())+'\tNER-Ignored')
                        elif(token.ent_type_!=""):
                            if((token.is_punct== False or (token.is_punct== True and token.text=="-")) and token.text!=doc[token.i-1].text and (( token.dep_!='prep' or (token.dep_=='prep' and token.pos_=="NOUN")) and token.dep_!='det' and token.pos_!="ADP" and token.dep_!='cc' and (token.text!='also' and doc[token.i-1].text!='and'))):
                                if(token.like_url==True):
                                    dic['Data']=dic['Data']+ ' , '+tokenword
                                    # print(token.ent_type_,"\t",token.text,'\t',token.pos_,'\t',token.dep_,'\t',token.like_url,'\t',lemmas.lower(),'\tNER-Event')
                                    logger.info(str(token.ent_type_) + "\t"+str(token.text) +'\t'+str(lemmas.lower())+'\tData')
                                    if(token.like_url==True and dic['Control']==''):
                                        dic['Control']='toUrl'
                                elif(token.ent_type_=="event" and token.is_punct== False and token.is_digit== False):
                                    if(dic['Event']=='' and token.text!="and"):
                                        if(lemmas!='be'):
                                            dic['Event']=token.text
                                            # print(token.ent_type_,"\t",token.text,'\t',token.pos_,'\t',token.dep_,'\t',token.like_url,'\t',lemmas.lower(),'\tNER-Event')
                                            logger.info(str(token.ent_type_) +'\t'+str(lemmas.lower())+'\tNER-Event')
                                        else:
                                            dic['Event']=andSpliter(oristatement)
                                    else:
                                        dic['NER Repository']==token.text+'-'+token.ent_type_
                                        # print(token.ent_type_,"\t",token.text,'\t',token.pos_,'\t',token.dep_,'\t',token.like_url,'\t',lemmas.lower(),'\tNER-Event')
                                        logger.info(str(token.ent_type_) + "\t"+str(token.text) +'\t'+str(lemmas.lower())+'\tNER-Repository')
                                elif(token.ent_type_=="control"):
                                    if(dic['Control']==''):
                                        dic['Control']=token.lemma_
                                        # print(token.ent_type_,"\t",token.text,'\t',token.pos_,'\t',token.dep_,'\t',token.like_url,'\t',lemmas.lower(),'\tNER-Event')
                                        logger.info(str(token.ent_type_) + "\t"+str(token.text) +'\t'+str(lemmas.lower())+'\tNER-Control')
                                    else:
                                        dic['NER Repository']==token.text+'-'+token.ent_type_
                                        # print(token.ent_type_,"\t",token.text,'\t',token.pos_,'\t',token.dep_,'\t',token.like_url,'\t',lemmas.lower(),'\tNER-Event')
                                        logger.info(str(token.ent_type_) + "\t"+str(token.text) +'\t'+str(lemmas.lower())+'\tNER-Repository')
                                elif(token.ent_type_=="controlText" ):
                                    if( dic['Control text'].lower().lstrip().rstrip().find(tokenword.lower().lstrip().rstrip())==-1):
                                        dic['Control text']=dic['Control text']+ ' '+tokenword
                                        # print(token.ent_type_,"\t",token.text,'\t',token.pos_,'\t',token.dep_,'\t',token.like_url,'\t',lemmas.lower(),'\tNER-Event')
                                        logger.info(str(token.ent_type_) + "\t"+str(token.text) +'\t'+str(lemmas.lower())+'\tNER-ControlText')
                                    elif(doc[token.i-1].text== '"'):
                                        stratin=dic['Control text'].lstrip().rstrip().lower().find(tokenword.lower().lstrip().rstrip())
                                        dic['Control text']=dic["Control text"].lstrip().rstrip()[:stratin]+tokenword.lstrip().rstrip() + dic["Control text"].lstrip().rstrip()[stratin+len(tokenword):]
                                        # print(token.ent_type_,"\t",token.text,'\t',token.pos_,'\t',token.dep_,'\t',token.like_url,'\t',lemmas.lower(),'\tNER-Event')
                                        logger.info(str(token.ent_type_) + "\t"+str(token.text) +'\t'+str(lemmas.lower())+'\tNER-ControlText')
                            else:
                                logger.info(str(token.ent_type_) + "\t"+str(token.text) +'\t'+str(lemmas.lower())+'\tIgnored')
                        else:
                            if(token.is_punct== False and token.text!=doc[token.i-1].text and (( token.dep_!='prep' or (token.dep_=='prep' and token.pos_=="NOUN")) and token.dep_!='det' and token.pos_!="ADP" and token.dep_!='cc' and (token.text!='also' and doc[token.i-1].text!='and'))):
                                if (token.pos_=="SPACE" or lemmas.lower()=='mouse' or lemmas.lower()=='valid'):
                                    logger.info(str(token.ent_type_) +'\t'+str(lemmas.lower())+'\tIgnored')
                                    # print(token.ent_type_,"\t",token.text,'\t',token.pos_,'\t',token.dep_,'\t',token.like_url,'\t',lemmas.lower(),'\tNER-Event')
                                    logger.info(str(token.ent_type_) + "\t"+str(token.text) +'\t'+str(lemmas.lower())+'\tIgnored')
                                elif (token._.is_control and token.like_url==False):
                                    if(dic['Control']==""):
                                        dic['Control']=token.lemma_
                                        # print(token.ent_type_,"\t",token.text,'\t',token.pos_,'\t',token.dep_,'\t',token.like_url,'\t',lemmas.lower(),'\tNER-Event')
                                        logger.info(str(token.ent_type_) + "\t"+str(token.text) +str(lemmas.lower())+'\tControl')
                                    else:
                                        dic['repository']=dic['repository']+ ' '+tokenword
                                        # print(token.ent_type_,"\t",token.text,'\t',token.pos_,'\t',token.dep_,'\t',token.like_url,'\t',lemmas.lower(),'\tNER-Event')
                                        logger.info(str(token.ent_type_) + "\t"+str(token.text) +str(lemmas.lower())+'\tRepository')
                                elif(token.like_url==True):
                                    dic['Data']=dic['Data']+ ' , '+tokenword
                                    # print(token.ent_type_,"\t",token.text,'\t',token.pos_,'\t',token.dep_,'\t',token.like_url,'\t',lemmas.lower(),'\tNER-Event')
                                    logger.info(str(token.ent_type_) + "\t"+str(token.text) +'\t'+str(lemmas.lower())+'\tData')
                                    if(token.like_url==True and dic['Control']==''):
                                        dic['Control']='toUrl'
                                elif(token.i-2 >0 and doc[token.i-2].text=="as"):
                                    dic['Data']=dic['Data']+ ' , '+tokenword
                                    # print(token.ent_type_,"\t",token.text,'\t',token.pos_,'\t',token.dep_,'\t',token.like_url,'\t',lemmas.lower(),'\tNER-Event')
                                    logger.info(str(token.ent_type_) + "\t"+str(token.text) +'\t'+str(lemmas.lower())+'\tData')
                                    if(token.like_url==True and dic['Control']==''):
                                        dic['Control']='toUrl'
                                elif (((token.pos_=='ADJ' and token.dep_!='compound') or (token.pos_=='VERB' and token.dep_!='amod')) and (token.is_digit==False and token.is_punct==False)):
                                    if(dic['Event']==''):
                                        if(lemmas!='be'):
                                            dic['Event']=token.text
                                            # print(token.ent_type_,"\t",token.text,'\t',token.pos_,'\t',token.dep_,'\t',token.like_url,'\t',lemmas.lower(),'\tNER-Event')
                                            logger.info(str(token.ent_type_) + '\t'+str(lemmas.lower())+'\tEvent')
                                        else:
                                            dic['Event']=andSpliter(oristatement)
                                    else:
                                        dic['repository']=dic['repository']+ ' '+tokenword
                                        # print(token.ent_type_,"\t",token.text,'\t',token.pos_,'\t',token.dep_,'\t',token.like_url,'\t',lemmas.lower(),'\tNER-Event')
                                        logger.info(str(token.ent_type_) + "\t"+str(token.text) +'\t'+str(lemmas.lower())+'\tRepository')
                                elif (token.pos_=='PROPN' or token.pos_=='NOUN' or token.pos_=='ADV' or token.pos_=='ADJ'):
                                    if(dic['Control text'].lstrip().rstrip().lower().find(lemmas.lower().lstrip().rstrip())==-1):
                                        tokenwordq=Xa.iloc[i][col[0]][starttokentext2:(starttokentext2+len(doc[token.i-1].text))]
                                        dic['repository']=dic['repository']+ ' '+tokenword
                                        # print(token.ent_type_,"\t",token.text,'\t',token.pos_,'\t',token.dep_,'\t',token.like_url,'\t',lemmas.lower(),'\tNER-Event')
                                        logger.info(str(token.ent_type_) + "\t"+str(token.text) +'\t'+str(lemmas.lower())+'\tRepository')
                                else:
                                    # print(token.ent_type_,"\t",token.text,'\t',token.pos_,'\t',token.dep_,'\t',token.like_url,'\t',lemmas.lower(),'\tNER-Event')
                                    logger.info(str(token.ent_type_) + "\t"+str(token.text) +'\t'+str(lemmas.lower())+'\tIgnored-nonNER')
                            else:
                                # print(token.ent_type_,"\t",token.text,'\t',token.pos_,'\t',token.dep_,'\t',token.like_url,'\t',lemmas.lower(),'\tNER-Event')
                                logger.info(str(token.ent_type_) + "\t"+str(token.text) +'\t'+str(lemmas.lower())+'\tIgnored')
                else:
                    dic['Control text']=dic['Original statement']
                dic['Control text']=dic['Control text'].lstrip()
                dic['Control text']=dic['Control text'].rstrip()
                dic['Control text']=dic['Control text'].replace("'","").replace('"',"")
                dic['Event']=dic['Event'].lstrip()
                dic['Event']=dic['Event'].rstrip()
                dic['Event']=dic['Event'].replace("'","").replace('"',"")
                dic['Control']=dic['Control'].lstrip()
                dic['Control']=dic['Control'].rstrip()
                dic['Data']=dic['Data'].lstrip()
                dic['Data']=dic['Data'].rstrip()
                dic['Data']=dic['Data'].replace(',',"",1)
                if(dic['Event']=='verify'):
                    if(dic["Control text"].lower().find("header")!=-1):
                        dic['Event']="verifyHeader"
                        dic["Control text"]=re.sub("[hH]eaders*","",dic["Control text"])
                    elif(dic["Control text"].lower().find("footer")!=-1):
                        dic['Event']="verifyFooter"
                        dic["Control text"]=re.sub("[Ff]ooters*","",dic["Control text"])
                if(dic["Control text"].lower().find("footer")!=-1):
                    evenf=['verify','click','scroll']
                    if(dic['Event'] not in evenf):
                        dic['Event']="verifyFooter"
                        dic["Control text"]=re.sub("[Ff]ooters*","",dic["Control text"])
                rawpagedic[i+1]=dic
                if(dic['Event']=='' and pagei!=0):
                    eventemp=pagedic[pagei]
                    dic['Event']=eventemp["Event"]
                if(dic['Control']==''):
                    event=dic['Event']
                    controltext=dic['Control text']
                    controltext=controltext.split(" ")
                    tempcorp=corpus.loc[corpus["Event"] == event]
                    rowcorp=len(tempcorp.index)
                    corpflag=0
                    for indcontroltext in controltext:
                        for corpr in range(0, rowcorp):
                            if(tempcorp.iloc[corpr]["Control text"].find(indcontroltext)!=-1 and tempcorp.iloc[corpr]["Control"].lstrip().rstrip()!="omitTheValueRK"):
                                dic['Control']=tempcorp.iloc[corpr]["Control"]
                                corpflag+=1
                                break
                        if(corpflag==1):
                            break
                if(dic["Event"].find("open")!=-1 and dic['Control text'].find("browser")!=-1):
                    dic["Event"]="openBrowser"
                    dic["Control"]=""
                tot=Xc.shape
                if(Xcbreak==1 and i<=(tot[0]-1)):
                    dic["Expected Results"]=Xc.iloc[i][colc[0]]
                else:dic["Expected Results"]=""
                # dic["Actexpreso"]="dumRKmy"
                # if(Xcbreak==1 and i<=(tot[0]-1)):
                #     if(Xc.iloc[i][colc[0]].lstrip().rstrip()==""):
                #         expresi=1
                #         while True:
                #             if(Xc.iloc[i+expresi][colc[0]].lstrip().rstrip()==""):
                #                 expresi+=1
                                
                #             else:
                #                 if((i+expresi>(tot[0]-1)) or pagei==0):
                #                     break
                                
                #                 if(pagedic[pagei]["Expected Results"]!=Xc.iloc[i+expresi][colc[0]].lstrip().rstrip()):
                #                     dic["Actexpres"]=Xc.iloc[i+expresi][colc[0]].lstrip().rstrip()
                #                     dic["Actexpreso"]=dic["Actexpres"] 
                #                     break
                #                 else:
                #                     dic["Actexpres"]=pagedic[pagei]["Actexpres"]
                #                     dic["Actexpreso"]=pagedic[pagei]["Actexpreso"] 
                #                     break
                #     else:
                #         dic["Actexpres"]=Xc.iloc[i][colc[0]].lstrip().rstrip()
                #     dic["Expected Results"]=Xc.iloc[i][colc[0]]
                # else:
                #       dic["Expected Results"]=""
                #       dic["Actexpres"]=""
                # expflags=0
                # if(Xcbreak==1 and ("Actexpres" in dic.keys())):
                #     if(dic["Actexpres"].find("\n")!=-1):
                #         dic["Actexpres"]=dic["Actexpres"].replace("\n",", ")
                #         dic["Actexpres"]=dic["Actexpres"].replace(", ,",",")
                #     if(dic["Actexpres"].find(",")!=-1):
                #         dic["Actexpres"]=dic["Actexpres"].replace("along with","and")
                #         dic["Actexpres"]=dic["Actexpres"].replace(" - "," ")
                #         dic["Actexpres"]=dic["Actexpres"].replace(" and ",",")
                #         dic["Actexpres"]=dic["Actexpres"].replace("  "," ")
                #         expflags=1
                #         teststep,pagedic,pagei=actexpres(dic,teststep,pagedic,pagei)
                pagedic[pagei+1]=dic
                pagei+=1
                if(l == int(len(Xa.index))):
                    # if(dic["Actexpres"]!="" and dic["Actexpres"]!="dumRKmy" and expflags==1):
                    #     teststep,pagedic,pagei=actexpres(dic,teststep,pagedic,pagei)
                    dic={'NER Repository':'','repository':'','Acceptance':'Pending','Original statement':'Quit the Browser','Control text':'','Event':'quitBrowser','Data':'','Control':'','Test Case ID':a[j]+"_TC_"+str(testcasevalue).replace("TC_",""),"Test Step ID":a[j]+"_TC_"+str(testcasevalue).replace("TC_","")+"_"+str("{:03d}".format(teststep)),'Expected Results':'Quit the Browser'}
                    pagedic[pagei+1]=dic
                    pagei+=1
    #    Extracting Test data
        Xb=rawDic[a[j]]
        col=Xb.columns.values.tolist()
        titlelst=["Test data","Testdata"]
        XbColumnsValues=Xb.columns.values.tolist()
        Xbbreak=0
        for colnum in range(Xb.shape[1]):
            for rownum in range(Xb.shape[0]):
                for titlename in titlelst:
                    if(Xbbreak==0 and str(Xb.iloc[rownum][col[colnum]]).lower().find(titlename.lower())!=-1):
                        teststepindex[a[j]+"test data"]=[rownum,colnum]
                        Xbbreak=1
        if(a[j]+"test data" in teststepindex.keys()):
            df1,df2 = np.split(Xb, [teststepindex[a[j]+"test data"][0]], axis=0)
            df1,df=np.split(df2, [teststepindex[a[j]+"test data"][1]], axis=1)
            df,df1=np.split(df, [1], axis=1)
            df.columns = df.iloc[0]
            df=df.dropna(how='all', axis=1)
            df=df.dropna(how='all', axis=0)            
            df=df.reset_index(drop =True)
            Xb=df
            col=Xb.columns.values.tolist()
            Xb=splitDataFrameList(df=Xb, target_column=col[0], separator="\n",splcategory=r'\nhttp',replacesplcat=' http')
            Xbbreak=1
        if(Xbbreak==1):
            col=Xb.columns.values.tolist()
            testDatadict={}
            testDatadict=Xb.to_dict()
            testDatadict=testDatadict[col[0]]
            testDatadictindex=list(testDatadict.keys())
            testdatacounter=-1
            testdatacounterqwed=len(testDatadictindex)-1
            while testdatacounter < testdatacounterqwed:
                testdatacounter+=1
                sample=testDatadictindex[testdatacounter]
                TDcache=testDatadict.pop(sample)
                if(type(TDcache)==float):
                    TDcache=str(TDcache)
                if(TDcache!='nan'):
                    if(TDcache.find("http")==0 or TDcache.find("www.")==0):
                        TDcache="url:"+TDcache
                    TDcache=TDcache.replace(":","tcmrkdelimiter",1)
                    TDcache=TDcache.replace("=","tcmrkdelimiter",1)
                    if(TDcache.lower().find("httptcmrkdelimiter")!=-1 or TDcache.lower().find("httpstcmrkdelimiter")!=-1):
                        TDcache=TDcache.replace("httptcmrkdelimiter","urltcmrkdelimiterhttp:",1)
                    TDcache=TDcache.split("tcmrkdelimiter")
                    if(len(TDcache)==2):
                        testDatadict[str(TDcache[0]).lstrip().rstrip()]=TDcache[1].lstrip().rstrip()                
        #    addding data from test data
            pagedicindex=list(pagedic.keys())
            testDatadictindex=list(testDatadict.keys())
            for sample in pagedicindex:
                if(pagedic[sample]['Data']==''):
                    for sample1 in testDatadictindex:
                        if(pagedic[sample]['Control text'].lower().find(str(sample1).lower())!=-1):
                            pagedic[sample]['Data']=testDatadict[sample1]
                            if(str(sample1).lower()=="url"):
                                pagedic[sample]['Control']="toUrl"  
                            break
                        elif(pagedic[sample]['Control'].lower().find("toUrl".lower())!=-1 and str(sample1).lower()=="url"):
                            pagedic[sample]['Data']=testDatadict[sample1]
                            break
        defaultstatement=['Open the Browser','Quit the Browser']
        dfpage=pd.DataFrame.from_dict(pagedic)
        dfpage=dfpage.T
        dfp3=pd.DataFrame.from_dict(rawpagedic)
        dfp3=dfp3.T
        dfp2=dfp2.append(dfp3.filter(['Original statement','Control','Control text','Event']))
        dfp2=dfp2.drop_duplicates()
        dfpage['Event'].replace('enter','enterText', inplace=True)
        dfpage['Event'].replace('choose','select', inplace=True)
        mask=((dfpage['Event']=='load') | (dfpage['Event']=='look') | (dfpage['Event']=='check') | (dfpage['Event']=='ensure'))
        dfpage.loc[mask,'Event']='verify'
        dfpage['Control'].replace('icon','button', inplace=True)
        mask=((dfpage['Control']=='text') | (dfpage['Control']=='field'))
        dfpage.loc[mask,'Control']='textbox'        
        mask=((dfpage['Control']=='textbox') & (dfpage["Event"]!="verify"))
        dfpage.loc[mask,'Event']='enterText'
        mask=((dfpage['Control']=='toUrl') & (dfpage['Data']!='') & (dfpage['Original statement']!='Got from Expected Results'))
        dfpage.loc[mask,'Event']='navigateToUrl'
        mask=((dfpage['Event']=='navigateToUrl') & (dfpage['Original statement']!='Got from Expected Results'))
        dfpage.loc[mask,'Control text']=''
        mask=((dfpage['Control']=='') & (dfpage['Event']=='select'))
        dfpage.loc[mask,'Control']='link'
        mask=((dfpage['Control']=='') & (dfpage['Event']=='verify'))
        dfpage.loc[mask,'Control']='validate'
        mask=(((dfpage['Control']=='button') | (dfpage['Control']=='link') | (dfpage['Control']=='dropdown')) & (dfpage['Event']==''))
        dfpage.loc[mask,'Event']='click'
        mask=((dfpage['Control']=='') & (dfpage['Event']=='click'))
        dfpage.loc[mask,'Control']='button'
        mask=((dfpage['Control']=='') & (dfpage['Event']=='search'))
        dfpage.loc[mask,'Control']='keyboardEnter'
        mask=((dfpage['Control']=='') & (dfpage['Event']=='apply'))
        dfpage.loc[mask,'Control']='button'
        mask=(dfpage['Event']=='enterText')
        dfpage.loc[mask,'Control']='textbox'
        mask=((dfpage['Data']=='') & (dfpage['Event']=='openBrowser'))
        dfpage.loc[mask,'Data']='Chrome'
        mask=(dfpage['Control']=='validate')
        dfpage.loc[mask,'Control']='link'
        for qwi in range(1,dfpage.shape[0]):
            if ((dfpage.loc[qwi,["Event"]].iloc[0] not in corcorrect) and (qwi-1>0)):
                dfpage.at[qwi,["Event"]]=dfpage.loc[qwi-1,["Event"]].iloc[0]
            if ((dfpage.loc[qwi,["Control"]].iloc[0] not in corcorrect1) and (qwi-1>0)):
                dfpage.at[qwi,["Control"]]=""
        dfpage.to_excel(writer,sheet_name=a[j],
                        index=True,
                        index_label='Sr.no',
                        columns=['Test Case ID',
                                 "Test Step ID",
                                 'Control',
                                 'Control text',
                                 "Data",
                                 'Event',
                                 'Acceptence',
                                 'Expected Results',
                                 'Original statement',
                                 'repository'
                                 ]
                        )
        dfpage.to_excel(writer1,sheet_name=a[j],
                        index=True,
                        index_label='Sr.no',
                        columns=['Test Case ID',
                                 "Test Step ID",
                                 'Control',
                                 'Control text',
                                 'repository',
                                 'NER Repository',
                                 "Data",
                                 'Event',
                                 "Actexpres",
                                 "possible control Text",
                                 'Expected Results',
                                 'Original statement'
                                 ]
                        )
        logger.info('{:-^40}'.format(""))
        logger.info(a[j]+" process completed in "+str(datetime.datetime.now()-sttime)+"\n\n")
        sttime=datetime.datetime.now()
    logger.info("overall process completed in "+str(datetime.datetime.now()-starttime))
    writer.save()
    writer1.save()
    corpus=corpus.append(dfp2)
    corpus=corpus.drop_duplicates()
    corpus['Control'].replace('omitTheValueRK', np.nan, inplace=True)
    corpus['Event'].replace('omitTheValueRK', np.nan, inplace=True)
    corpus['Control text'].replace('omitTheValueRK', np.nan, inplace=True)
    corpus.to_excel(corpus1,
                    sheet_name='corpus',
                    index=False,
                    index_label='Sr.no')
    corpus1.save()
    col=Xa.columns.values.tolist()
    print(str(datetime.datetime.now()-starttime))
except Exception as e:
    logging.error('Error occurred : ' + str(e))
    logging.error(traceback.print_exc())
#logging.shutdown()