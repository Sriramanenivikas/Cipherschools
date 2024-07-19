# -*- coding: utf-8 -*-
"""Data Cleaning.ipynb

"""

import pandas as pd
df = pd.read_csv("/marksheet.csv")
print(df)

#Identiying Missing Value
print(df.isnull().sum())

df.info()

#Removing rowa with misssing vlaues
df_clear = df.dropna()
print(df_clear)

# Filling missing values with the mean of the respective columns

import pandas as pd

df = pd.read_csv('/marksheet.csv')
df_filled = df.fillna({
    'Age': df['Age'].mean(),
    'Science': df['Science'].mean(),
    'English': df['English'].mean(),
    'History': df['History'].mean(),
    'Maths': df['Maths'].mean()
})
print(df_filled)

#Forward Fill Method
#forward fill Method to propagate the next values backward
df_ffill = df.fillna(method='ffill')
print(df_ffill)

#backward fill method
df_bfill = df.fillna(method='bfill')
print(df_bfill)

#Removing Duplicates
df = pd.concat([df,df.iloc[0],df.iloc[[2]]],ignore_index=True)
print('Before removing duplicates:\n',df)
#Remove duplicated rows
df_no_dupicated=df.drop_duplicates()
print('After removing duplicated:\n',df_no_dupicated)

#Replace incorrect the values in the 'Scinece' coloums
df_corrected  = df.replace({'Science': {'21': '99'}})
print(df_corrected)

#Ensuring Consistency
#converting to lower case to higer case
df['Name'] = df['Name'].str.upper()
print(df)

#Min and Max Normalization
df_normalized = df.copy()
for col in ['Age','Science']:
  df_normalized[col]=(df[col]-df[col].min())/(df[col].max()-df[col].min())
  print("Orginal DataFrame")
  print(df)
  print("\nNormalized DataFrame ")
  print(df_normalized)
