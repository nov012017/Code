
import pandas as pd
import pickle
from sklearn.externals import joblib
from flask import Flask, request, jsonify

app = Flask(__name__)


with open('C:/Users/phsivale/Documents/Trainings/flaskPOC/bin22Apr.pkl', 'rb') as file:
	binz = pickle.load(file)
with open('C:/Users/phsivale/Documents/Trainings/flaskPOC/model22Apr.pkl', 'rb') as file:
	clf = pickle.load(file)
#binz = joblib.load('C:/Users/phsivale/Documents/Trainings/flaskPOC/bin29March.pkl')
#clf = joblib.load('C:/Users/phsivale/Documents/Trainings/flaskPOC/model29March.pkl')

@app.route('/predict', methods=['POST'])
def predict():
	json_ = request.get_json(force =True)
	#requestDF = pd.read_csv(json_['path'])
	requestDF = pd.DataFrame(json_)
	
	data_bin = pd.DataFrame(binz.transform(requestDF['Home']))
	requestDF.drop(['Home'],axis=1,inplace=True) 
	requestDF =pd.concat([requestDF,data_bin],axis=1)
	print(requestDF)

	preds = clf.predict(requestDF)
	return jsonify({'prediction': str(preds)})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)




