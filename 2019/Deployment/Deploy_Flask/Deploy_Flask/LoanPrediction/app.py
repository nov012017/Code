# -*- coding: utf-8 -*-
"""
Created on Tue Sep 17 14:04:13 2019

@author: prudi
"""

from flask import Flask, render_template, request
from sklearn.externals import joblib
import pandas as pd
import numpy as np

app = Flask(__name__)

#mul_reg = open("multiple_regression_model.pkl", "rb")
#ml_model = joblib.load(mul_reg)

@app.route("/")
def home():
    return render_template('home.html')

#LoanAmount
standardScaler = open('standardscaler_pickle.pkl', 'rb')
standardScaler_load = joblib.load(standardScaler)

#ApplicantIncome
minmax = open('minmax_pickle.pkl', 'rb')
minmax_load = joblib.load(minmax)

#'Education','Property_Area','Loan_Status','Dependents','Credit_History'
encoder = open('labelencoder_pickle.pkl', 'rb')
encoder_load = joblib.load(encoder)

@app.route("/predict", methods=['GET', 'POST'])
def predict():
    print("I was here 1")
    if request.method == 'POST':
        print(request.form.get('NewYork'))
        try:
            CoapplicantIncome = float(request.form['CoapplicantIncome'])
            Loan_Amount_Term = float(request.form['Loan_Amount_Term'])
            #ApplicantIncome_minmax = float(request.form['ApplicantIncome_minmax'])
            ApplicantIncome_minmax=minmax_load['ApplicantIncome'].transform(np.array(float(request.form['ApplicantIncome_minmax'])).reshape(-1,1))[0][0]
            #LoanAmount_minmax = float(request.form['LoanAmount_minmax'])
            LoanAmount_minmax=standardScaler_load['LoanAmount'].transform(np.array(float(request.form['LoanAmount_minmax'])).reshape(-1,1))[0][0]
            Married_0 = int(request.form['Married_0'])
            Gender_0 = int(request.form['Gender_0'])
            Gender_1 = int(request.form['Gender_1'])
            Gender_2 = int(request.form['Gender_2'])
            Education_0 =int(request.form['Education_0'])
            Property_Area_0 = int(request.form['Property_Area_0'])
            Loan_Status_0 = int(request.form['Loan_Status_0'])
            Dependents_0 = int(request.form['Dependents_0'])
            pred_args = [CoapplicantIncome,Loan_Amount_Term,ApplicantIncome_minmax,LoanAmount_minmax,Married_0,Gender_0,Gender_1,Gender_2,Education_0,Property_Area_0,Loan_Status_0,Dependents_0]
            pred_args_arr = np.array(pred_args)
            pred_args_arr = pred_args_arr.reshape(1, -1)
            mul_reg = open("LogisticRegression_MODEL.pkl", "rb")
            ml_model = joblib.load(mul_reg)
            model_prediction = ml_model.predict(pred_args_arr)
            model_prediction = model_prediction
        except ValueError:
            return "Please check if the values are entered correctly"
    return render_template('predict.html', prediction = model_prediction)


if __name__ == "__main__":
    #app.run(port=9000,debug=True)
    app.run(host='0.0.0.0')
