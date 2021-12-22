# -*- coding: utf-8 -*-
"""ModelTraining.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1gRdKnTQdfT6CaBVUPii8C3Y2HDQzGTgC
"""

import pandas as pd

df = pd.read_csv('Avocado.csv')
region_collection = {}
region_collection_reverse = {}
processing_data = df.copy()

# data processing
for col in df.columns:
  for i in range(len(df[col])):
    if col == 'type':
      if processing_data[col][i] == 'conventional':
        processing_data[col][i] = 0
      else:
        processing_data[col][i] = 1
    elif col == 'region':
      if processing_data[col][i] not in region_collection:
        region_collection[processing_data[col][i]] = len(region_collection)
        region_collection_reverse[len(region_collection)-1] = processing_data[col][i]
      processing_data[col][i] = region_collection[processing_data[col][i]]

processing_data['month'] = pd.DatetimeIndex(processing_data['Date']).month

training_data = processing_data.drop(['Unnamed: 0', 'Date', '4046', '4225', '4770', 'year', 'Total Bags',	'Small Bags',	'Large Bags',	'XLarge Bags'], axis=1)

training_data.to_csv('training_data.csv', index=False)

sk_dataset = []
# apply one hot encoder
for index, record in training_data.iterrows():
  data = {}
  data['price'] = [record['AveragePrice']]
  data['consumption'] = [record['Total Volume']]
  feature_type = [1 if record['type']==i else 0 for i in range(2) ]
  feature_region = [1 if record['region']==i else 0 for i in range(len(region_collection))]
  feature_month = [1 if record['month']==i+1 else 0 for i in range(12)]
  data['features'] = feature_type+feature_region+feature_month
  sk_dataset.append(data)

import random
# split training and testing dataset
random.seed(1)
random.shuffle(sk_dataset)
train_dataset = sk_dataset[:16000]
test_dataset = sk_dataset[16000:]

import numpy as np
X = []
y_price = []
y_consumption = []
for sample in train_dataset:
  X.append(sample['features'])
  y_price.append(sample['price'])
  y_consumption.append(sample['consumption'])
X = np.array(X)
y_price = np.array(y_price)
y_consumption = np.array(y_consumption)

X_test = []
y_price_test = []
y_consumption_test = []
for sample in test_dataset:
  X_test.append(sample['features'])
  y_price_test.append(sample['price'])
  y_consumption_test.append(sample['consumption'])
X_test = np.array(X_test)
y_price_test = np.array(y_price_test)
y_consumption_test = np.array(y_consumption_test)

# model evaluation
from sklearn.metrics import r2_score, mean_absolute_error, mean_absolute_percentage_error
def evaluateModel(model, model_name, class_name, x_test, y_test):
  y_pred = model.predict(x_test)
  print('The r2 score of {model_} for {class_} prediction on test dataset is {score_}'.
        format(model_=model_name, class_=class_name, score_=model.score(x_test,y_test)))
  print('The MAE (mean absolute error) of {model_} for {class_} prediction on test dataset is {score_}'.
        format(model_=model_name, class_=class_name, score_=mean_absolute_error(y_pred, y_test)))
  print('The MAPE (mean absolute percentage error) of {model_} for {class_} prediction on test dataset is {score_}'.
        format(model_=model_name, class_=class_name, score_=mean_absolute_percentage_error(y_pred, y_test)))

# model 
from sklearn.linear_model import LinearRegression, BayesianRidge, QuantileRegressor
from sklearn import svm
from sklearn.ensemble import RandomForestRegressor
from sklearn import linear_model
R_reg = linear_model.Ridge(alpha=.5).fit(X, y_price)
svm_regr = svm.SVR().fit(X, y_price)
rf_regr = RandomForestRegressor(max_depth=4, random_state=0).fit(X, y_price)
lr_model = LinearRegression().fit(X, y_price)
nb_model = BayesianRidge().fit(X, y_price)

evaluateModel(lr_model,'linear','price',X_test,y_price_test)
evaluateModel(R_reg,'Ridge','price',X_test,y_price_test)
evaluateModel(nb_model,'BayesRinge','price',X_test,y_price_test)
evaluateModel(rf_regr,'RandomForest','price',X_test,y_price_test)
evaluateModel(svm_regr,'SVM Regression','price',X_test,y_price_test)

R_reg_2 = linear_model.Ridge(alpha=.5).fit(X, y_consumption)
svm_regr_2 = svm.SVR().fit(X, y_consumption)
rf_regr_2 = RandomForestRegressor(max_depth=4, random_state=0).fit(X, y_consumption)
lr_model_2 = LinearRegression().fit(X, y_consumption)
nb_model_2 = BayesianRidge().fit(X, y_consumption)

evaluateModel(lr_model_2,'linear','price',X_test,y_consumption_test)
evaluateModel(R_reg_2,'Ridge','price',X_test,y_consumption_test)
evaluateModel(nb_model_2,'BayesRinge','price',X_test,y_consumption_test)
evaluateModel(rf_regr_2,'RandomForest','price',X_test,y_consumption_test)
evaluateModel(svm_regr_2,'SVM Regression','price',X_test,y_consumption_test)

import pickle
# save the model to disk
filename = 'svm_model_price.sav'
pickle.dump(svm_regr, open(filename, 'wb'))

filename = 'rf_model_consumption.sav'
pickle.dump(rf_regr_2, open(filename, 'wb'))