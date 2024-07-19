# -*- coding: utf-8 -*-
"""Feature Engineering.ipynb

"""

#Handing Missing value
import pandas as pd
from sklearn.impute import SimpleImputer


#sample data
data = {
    'Feature1' : [1.0,2.0,None,4.0,5.0],
    'Feature2' : [2.0,3.0,None,1.0,1.0],
    'Feature3': [1.0,5.0,None,3.0,4.0]

}
df= pd.DataFrame(data)
imputer = SimpleImputer(strategy='mean')
df_imputed = pd.DataFrame(imputer.fit_transform(df), columns=df.columns)
print("After Imputation :\n" , df_imputed)

#Encoding Features Using the OneHotEncoder
import pandas as pd
from sklearn.preprocessing import OneHotEncoder
data = {
    'Color': ['Red', 'Blue', 'Green', 'Blue', 'Red']
}
df = pd.DataFrame(data)
encoder = OneHotEncoder(sparse=False)
encoded_categories = encoder.fit_transform(df[['Color']])
df_encoded = pd.DataFrame(encoded_categories, columns=encoder.get_feature_names_out(['Color']))
df_final = pd.concat([df, df_encoded], axis=1).drop('Color', axis=1)
print("After One-Hot Encoding:\n", df_final)

#Min and Max Scaling
import pandas as pd
from sklearn.preprocessing import MinMaxScaler

#sample data
data = {
    'Feature1' : [10,50,20,30,40],
    'Feature2' : [80,40,50,60,40]


}
df= pd.DataFrame(data)
#Feature Scaling
scaler = MinMaxScaler()
df_scaled = pd.DataFrame(scaler.fit_transform(df), columns=df.columns)
print("After Min MAx Scaling:\n", df_scaled)

#Feature Creation in the data
import pandas as pd
from sklearn.preprocessing import PolynomialFeatures
#sample data
data = {
    'Feature1' : [1,8,1,4,5],
    'Feature2' : [8,7,9,4,5]


}
df= pd.DataFrame(data)
#Creation of new Features
poly = PolynomialFeatures(degree=2,include_bias=False)
poly_features = poly.fit_transform(df)
df_poly = pd.DataFrame(poly_features, columns=poly.get_feature_names_out(['Feature1', 'Feature2']))
print("After Creation of a new Features\n: ", df_poly)

#Varaicens Thresholding
import pandas as pd
from sklearn.feature_selection import VarianceThreshold

# Sample data
data = {
    'Feature1': [1, 1, 1, 1, 1],
    'Feature2': [2, 3, 4, 5, 6],
    'Feature3': [3, 4, 5, 6, 7],
    'Constant': [1, 1, 1, 1, 1]
}

df = pd.DataFrame(data)

# Variance Thresholding
selector = VarianceThreshold(threshold=0.1)
df_variance_filtered = pd.DataFrame(selector.fit_transform(df), columns=df.columns[selector.get_support()])

print("After Variance Thresholding: \n", df_variance_filtered)

#Domain Knowleage
import pandas as pd

# Data
data = {
    'Age': [25, 30, 35, 40, 45],
    'Salary': [50000, 60000, 70000, 80000, 90000],
    'Height': [5.5, 6.0, 5.8, 5.9, 6.1],
    'Weight': [150, 160, 170, 180, 190]
}

df = pd.DataFrame(data)

selected_features_domain = df[['Age', 'Salary']]

print("Selected Features based on Domain Knowledge:\n", selected_features_domain)

