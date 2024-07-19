# -*- coding: utf-8 -*-
"""Supervised Learning Alogorithum.ipynb

"""

#Linear Regression Alogorithm


from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.metrics import  mean_squared_error
import numpy as np

#Generating the synthetic data
#X=np.random.rand(100,1)*10
X = np.random.rand(100, 1)*10
y = 2.5*X + np.random.randn(100,1)*2
#Splitting the data into the training and testing data
X_train,X_test,y_train,y_test=train_test_split(X,y,test_size=0.2,random_state=42)
#Traing the model
model =LinearRegression()
model.fit(X_train,y_train)

#Making predictions
y_pred=model.predict(X_test)
#Evaluating the model
mse = mean_squared_error(y_test,y_pred)
print(f"Mean Square Error: ",mse)

#Logistc Regression Alg
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score

#Loading the dataset
iris = load_iris()
X=iris.data
y = iris.target

#Using omly two class foe binary classifactions
X=X[y!=2]
y=y[y!=2]
#spitting data into training and testing data
X_train,X_test,y_train,y_test=train_test_split(X,y,test_size=0.2,random_state=42)
#Traing the model
model =LogisticRegression()
model.fit(X_train,y_train)

#Making predictions
y_pred=model.predict(X_test)
#Evaluating the model
accuracy = accuracy_score(y_test,y_pred)
print(f"Accuracy Score: ",accuracy)

#Decision Making tree
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import accuracy_score

#Using omly two class foe binary classifactions
X=X[y!=2]
y=y[y!=2]
#spitting data into training and testing data
X_train,X_test,y_train,y_test=train_test_split(X,y,test_size=0.2,random_state=42)
#Traing the model
model =DecisionTreeClassifier()
model.fit(X_train,y_train)


#Making predictions
y_pred=model.predict(X_test)
#Evaluating the model
accuracy = accuracy_score(y_test,y_pred)
print(f"Accuracy Score: ",accuracy)

#Support Vector Machine(Svm)
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
from sklearn.svm import SVC
from sklearn.metrics import accuracy_score
#Loading the dataset
iris = load_iris()
X=iris.data
y = iris.target


#Using omly two class foe binary classifactions
X=X[y!=2]
y=y[y!=2]
#spitting data into training and testing data
X_train,X_test,y_train,y_test=train_test_split(X,y,test_size=0.2,random_state=42)
#Traing the model
model = SVC()
model.fit(X_train,y_train)


#Making predictions
y_pred=model.predict(X_test)
#Evaluating the model
accuracy = accuracy_score(y_test,y_pred)
print(f"Accuracy Score: ",accuracy)

