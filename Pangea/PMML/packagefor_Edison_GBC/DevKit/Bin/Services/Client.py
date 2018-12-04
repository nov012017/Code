import socket
import glob, os,sys
import httplib
import json
import ConfigParser
import numpy as np
import pandas as pd
#from XMLParse import XMLParser
config = ConfigParser.ConfigParser()
cwd = os.getcwd()
confpath=cwd+"/DevKit/Etc/config.properties"
config.read(confpath)
tenantIDIP = config.get("myvars", "tenantIDIP")
root_path = config.get("myvars", "root_path")
port = config.get("myvars", "port")
print(port,tenantIDIP)
s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
class client:
	def run(self):
		headers = {'Content-type': 'application/json'}
		test = httplib.HTTPConnection(tenantIDIP,port)
		
		datafile="dataset1"
		
		response=test.request('POST', '/markdown',datafile,headers)
		r1 = test.getresponse()
		print("r1",r1)
		data = r1.read()
		resp=data.splitlines()
		
		return resp;

Edge=client()
response=Edge.run()
print("Succesfuly completed Predictions")
a=eval(response[5])
print(dict(pd.Series(a).value_counts()))


	

