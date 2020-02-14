import numpy as np
from flask import Flask, request, jsonify, render_template
import pickle
import pandas as pd
from sklearn.base import BaseEstimator, TransformerMixin

app = Flask(__name__)
model = pickle.load(open('DecisionTree.pkl', 'rb'))

MinMaxpickle_in = open("minmax_pickle.pkl","rb")
MinmaxScaler_dict = pickle.load(MinMaxpickle_in)

standardscaler_in = open("standardscaler_pickle.pkl","rb")
standardscaler_dict = pickle.load(standardscaler_in)

Onehotpickle_in = open("binarizer_pickle.pkl","rb")
Onehot_dict = pickle.load(Onehotpickle_in)

Labelencoderpickle_in = open("labelencoder_pickle.pkl","rb")
Labelencoder_dict = pickle.load(Labelencoderpickle_in)

Labelencoder_dict
@app.route('/')
def home():
    return render_template('index.html')

@app.route('/predict',methods=['POST'])
def predict():
    '''
    For rendering results on HTML GUI
    '''
    int_features = [x for x in request.form.values()]
    final_features = [np.array(int_features)]
    df=pd.DataFrame(final_features,columns=['Gender', 'Married', 'Dependents', 'Education',
       'Self_Employed', 'ApplicantIncome', 'CoapplicantIncome', 'LoanAmount',
       'Loan_Amount_Term', 'Credit_History', 'Property_Area'])
    
    df['Credit_History']=df['Credit_History'].astype(str)
    
    d1=pd.DataFrame(Onehot_dict['Self_Employed'].transform(df[['Self_Employed']]))
    d1.columns=['Self_Employed_0']
    d2=pd.DataFrame(Onehot_dict['Married'].transform(df[['Married']]))
    d2.columns=['Married_0']
    d3=pd.DataFrame(Onehot_dict['Gender'].transform(df[['Gender']]))
    d3.columns=['Gender_0','Gender_1','Gender_2']
    
    df['Dependents']=pd.DataFrame(Labelencoder_dict['Dependents'].transform(df[['Dependents']]))
    df['Education']=pd.DataFrame(Labelencoder_dict['Education'].transform(df[['Education']]))
    df['Property_Area']=pd.DataFrame(Labelencoder_dict['Property_Area'].transform(df[['Property_Area']]))
    df['Credit_History']=pd.DataFrame(Labelencoder_dict['Credit_History'].transform(df[['Credit_History']]))
    
    df['LoanAmount']=pd.DataFrame(standardscaler_dict['LoanAmount'].transform(df[['LoanAmount']]))
    df['ApplicantIncome']=pd.DataFrame(MinmaxScaler_dict['ApplicantIncome'].transform(df[['ApplicantIncome']]))
    
    df=pd.concat([df,d1,d2,d3],axis=1)
    
    df=df.drop(['Self_Employed','Married','Gender'],axis=1)
    
    prediction = model.predict(df)

    output = round(prediction[0], 2)

    if output==1:
        output='Loan Approved'
    else:
        output='Loan Rejected'

    return render_template('index.html', prediction_text='LOAN STATUS (Yes/NO)  :{}'.format(output))


if __name__ == "__main__":
    app.run(debug=True)