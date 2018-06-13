# Installing Theano
# pip install --upgrade --no-deps git+git://github.com/Theano/Theano.git

# Installing Tensorflow
# pip install tensorflow

# Installing Keras
# pip install --upgrade keras

# importing the libraries
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

# Loading the data
dataset = pd.read_csv('D:\Data Science\Deep Learning\sonar.csv', header = None)
X = dataset.iloc[:, 0:60].values
y = dataset.iloc[:, 60].values

# Feature Encoding
from sklearn.preprocessing import LabelEncoder, OneHotEncoder
encoder = LabelEncoder()
y = encoder.fit_transform(y)

# Splitting into training and test sets
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.25, random_state = 0)

# Feature Scaling
from sklearn.preprocessing import StandardScaler
sc = StandardScaler()
X_train = sc.fit_transform(X_train)
X_test = sc.transform(X_test)

# Building a SLP
# Importing Keras Libraries and packages
import keras 
from keras.models import Sequential
from keras.layers import Dense
from keras.layers import Dropout

# Initialize the ANN
classifier = Sequential()

# Build the input and hidden layers with dropout
classifier.add(Dense(units = 1, activation = 'sigmoid', kernel_initializer = 'uniform', input_dim = 60))
#classifier.add(Dropout(rate = 0.1))
classifier.add(Dropout(rate = 0.2))
########array([[25,  1],
#       [ 6, 20]], dtype=int64)
####By increasing Dropout rate,accuracy increased.
# Compiling the ANN
classifier.compile(optimizer = 'adam', loss = 'binary_crossentropy', metrics = ['accuracy'])

# Fitting ANN to training set
#classifier.fit(X_train, y_train, batch_size = 10, epochs = 10)
classifier.fit(X_train, y_train, batch_size = 5, epochs = 10)
####by taking low batch size,we can get better accuracy.
####array([[23,  3],
#       [ 7, 19]], dtype=int64)

# Predicting on test set
y_pred = classifier.predict(X_test) > 0.5

# Evaluating using confusion matrix
from sklearn.metrics import confusion_matrix
cm = confusion_matrix(y_test, y_pred)
cm
