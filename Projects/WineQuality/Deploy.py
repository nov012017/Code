# -*- coding: utf-8 -*-
"""
Created on Tue Nov 20 22:05:19 2018

@author: Admin
"""

import numpy as np
import pandas as pd
from flask import Flask,abort,jsonify,request
import _pickle as pickle

#loading a model from a file called model.pkl
pickle_in = open("C:\\Users\\prudi\\Documents\\GitHub\\Code\\Projects\\WineQuality\\model.pickle_sep_2019","rb")
example_dict = pickle.load(pickle_in)

app=Flask(__name__)
@app.route('/api',methods=['POST'])
def make_predict():
	data=request.get_json(force=True)
    ## all kinds of error checking should go here
	#dataDF=pd.DataFrame(json_)
    ## Convert our json to a numpy array
	predict_request=[data['fixed acidity'],data['volatile acidity'],data['citric acid'],data['residual sugar'],data['chlorides'],data['free sulfur dioxide'],data['total sulfur dioxide'],data['density'],data['pH'],data['sulphates'],data['alcohol']]
	print(predict_request)
	predict_request=np.array(predict_request).reshape(1,-1)
	
	#print(dataDF)
    ##np array goes into random forest, prediction comes out
	y_hat=example_dict.predict(predict_request)
	print(y_hat)
    ## return our prediction
	output=[y_hat[0]]
	return jsonify(results=output)
	#return y_hat

if __name__ == '__main__':
    app.run(debug=True, port=9000)