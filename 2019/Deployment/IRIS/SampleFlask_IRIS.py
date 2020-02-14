
# coding: utf-8

# In[37]:


import numpy as np
from flask import Flask, abort, jsonify, request
import pickle as pickle
import os
os.chdir("C:\\Users\\prudi\\Documents\\GitHub\\Code\\2019\\Deployment\\HousePricing")
my_random_forest=pickle.load(open('iris_rfc.pkl','rb'))

app=Flask(__name__)

@app.route('/api',methods=['POST'])

def make_predict():
    data=request.get_json(force=True)
    print(data)
    
    predict_request=[data['sl'],data['sw'],data['pl'],data['pw']]
    
    predict_request=np.array(predict_request)
    
    response = {}
    response['predictions'] = my_random_forest.predict([predict_request]).tolist()
    #y_hat=my_random_forest.predict(predict_request)
    
    #output=[y_hat[0]]
    
    #responses=jsonify(results=output)
    
    return (jsonify(response))

if __name__=="__main__":
    app.run(port=9000,debug=True)

