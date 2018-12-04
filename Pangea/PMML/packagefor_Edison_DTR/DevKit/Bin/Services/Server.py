from BaseHTTPServer import BaseHTTPRequestHandler, HTTPServer
import SocketServer
import sys
import random
import os
from augustus.strict import modelLoader
import pandas as pd
import numpy as np
import sys
import glob, os
import httplib
import datetime
import ConfigParser
from EdgeSource.Source import *

### Reading required vars from config
config = ConfigParser.ConfigParser()
cwd = os.getcwd()
confpath=cwd+"/DevKit/Etc/config.properties"
config.read(confpath)
tenantIDIP = config.get("myvars", "tenantIDIP")
root_path = config.get("myvars", "root_path")
port = config.get("myvars", "port")		
print(port,root_path)


class ModelData():
	
	def register(self,model,tid,root_path):
			EdgeOnModels= Edge()
			EdgeOnModels.registerModels(modelName=model,tenantID=tid)
			LodedModel=EdgeOnModels.LoadXML(sys.argv[2],sys.argv[3],root_path)
			return LodedModel

	def Predict(self,LodedModel,model,tenantId,root_path,object1):
			EdgeOnModels= Edge()
			df=EdgeOnModels.Predict(LodedModel,model,tenantId,root_path,object1)
			#print(df)
			return df
	def setModelConstrut(self,modelName,tenantID,modelXmlPath):
			EdgeOnModels= Edge()
			EdgeOnModels.setModelConstrut(modelName,tenantID,modelXmlPath)

	def setDataOutputXML(self,modelName,tenantID,modelXmlPath):
			EdgeOnModels= Edge()
			EdgeOnModels.setDataOutputXML(modelName,tenantID,modelXmlPath)
	
	def setDataTranslationXML(self,modelName,tenantID,modelXmlPath):
			EdgeOnModels= Edge()
			EdgeOnModels.setDataTranslationXML(modelName,tenantID,modelXmlPath)

		
	



		


############# For Predictions#################################	
def run_precict(data_string):
	modelData=ModelData()	
	object1=data_string
	print("in predict")
	df=modelData.Predict(LodedModel,model,tenantId,root_path,object1)
	return df
	
  
class S(BaseHTTPRequestHandler):
    def _set_headers(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()

    def do_GET(self):
        self._set_headers()
       

    def do_HEAD(self):
        self._set_headers()

    def do_POST(self):
		self._set_headers()
		print "in post method"
		data_string = self.rfile.read(int(self.headers['Content-Length']))
		print("data_string")
		resp=run_precict(data_string)
		self.send_response(200)
		self.send_header('Content-Type', 'application/json')
		self.end_headers()
		self.wfile.write(resp)
		
						

def run(server_class=HTTPServer, handler_class=S, port=8085):
    server_address = ('', port)
    httpd = server_class(server_address, handler_class)
    print ("Starting httpd")
    #thread.start_new_thread(httpd.serve_forever())
    httpd.serve_forever()


LodedModel=""
model=sys.argv[2]
tenantId=sys.argv[3]
modelData=ModelData()
if sys.argv[1]=="Register":
	print(sys.argv[1],sys.argv[2],sys.argv[3])
	LodedModel=modelData.register(sys.argv[2],sys.argv[3],root_path)
	run()
if sys.argv[1]=="setModelConstrut":
	EdgeOnModels= Edge()
	command="lsof -t -i tcp:8085 -s tcp:listen |  xargs kill"
	os.system(command)
	print(sys.argv[1],sys.argv[2],sys.argv[3],sys.argv[4])
	modelData.setModelConstrut(sys.argv[2],sys.argv[3],sys.argv[4])
	LodedModel=EdgeOnModels.LoadXML(sys.argv[2],sys.argv[3],root_path)
	run()
if sys.argv[1]=="setDataOutputXML":
	EdgeOnModels= Edge()
	command="lsof -t -i tcp:8085 -s tcp:listen |  xargs kill"
	os.system(command)
	print(sys.argv[1],sys.argv[2],sys.argv[3],sys.argv[4])
	modelData.setDataOutputXML(sys.argv[2],sys.argv[3],sys.argv[4])
	LodedModel=EdgeOnModels.LoadXML(sys.argv[2],sys.argv[3],root_path)
	run()
if sys.argv[1]=="setDataTranslationXML":
	EdgeOnModels= Edge()
	command="lsof -t -i tcp:8085 -s tcp:listen |  xargs kill"
	os.system(command)
	print(sys.argv[1],sys.argv[2],sys.argv[3],sys.argv[4])
	modelData.setDataTranslationXML(sys.argv[2],sys.argv[3],sys.argv[4])
	LodedModel=EdgeOnModels.LoadXML(sys.argv[2],sys.argv[3],root_path)
	run()








  
  

