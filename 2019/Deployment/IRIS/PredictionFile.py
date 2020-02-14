# -*- coding: utf-8 -*-
"""
Created on Thu Feb 13 08:42:04 2020

@author: prudi
"""
import requests,json
url="http://127.0.0.1:9000/api"
data=json.dumps({'sl':5.84,'sw':3.0,'pl':3.75,'pw':1.1})
r=requests.post(url,data)

print(r.json())