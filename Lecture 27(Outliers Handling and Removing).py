# -*- coding: utf-8 -*-
"""Outliers Handling.ipynb

"""

#load the dataset
import pandas as pd
df = pd.read_csv("/content/marksheet.csv")
print(df)

import matplotlib.pyplot as plt

#creation of box plots
plt.figure(figsize=(10,5))
plt.subplot(1,2,1)
plt.boxplot(df['Age'].dropna())
plt.title('Boxplot of Age')
plt.show()


#For the Science Marks
plt.subplot(1,2,2)
plt.boxplot(df['Science'].dropna())
plt.title('Boxplot of Science')
plt.show()

#Handing the outliers
df_capped = df.copy()

for column in ['Age', 'Science']:
    Q1 = df_capped[column].quantile(0.25)
    Q3 = df_capped[column].quantile(0.75)
    IQR = Q3 - Q1
    lower_bound = Q1 - 1.5 * IQR
    upper_bound = Q3 + 1.5 * IQR

    df_capped[column] = df_capped[column].apply(lambda x: upper_bound if x > upper_bound else (lower_bound if x < lower_bound else x))

print('Data after capping outliers using IQR method:')
print(df_capped)

#Replacing the Outliers
df_replaced = df.copy()

for column in ['Age', 'Science']:
    Q1 = df_replaced[column].quantile(0.25)
    Q3 = df_replaced[column].quantile(0.75)
    IQR = Q3 - Q1
    lower_bound = Q1 - 1.5 * IQR
    upper_bound = Q3 + 1.5 * IQR
    median = df_replaced[column].median()

    df_replaced[column] = df_replaced[column].apply(lambda x: median if x > upper_bound or x < lower_bound else x)

print('Data after replacing outliers with median values:')
print(df_replaced)

