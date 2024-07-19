# -*- coding: utf-8 -*-
"""Untitled4.ipynb

"""

#creation of a dataframes from a dicitionary
import pandas as pd
data = {
    'Name': ['Alice','laxman','raju'],
    'Age': [25,30,35],
    'City': ['India','usa','London']
}
df=pd.DataFrame(data)
print(df)

#creation a dataframes from a list of Dicitionary
data = [
    {'Name': 'Laxman','Age': 21,'City':'Warangal'}
]
df=pd.DataFrame(data)
print(data)

#using the csv file
df=pd.read_csv('marksheet.csv')
print(df)
print(df.head())
print(df.tail())
print(df.info())
print(df.describe())

#selecting single and multiple coloums
print(df['id'])
print(df[['id','Age']])

#filtering rows based on the condition
print(df[df['Age']>13])
#Adding new the single columuns

#Modifing the coloums existings
df['Age'] = df['Age'] +1
print(df)

#Dropping a coloums
df= df.drop(columns=['Maths'])
print(df)

#Dropping a row
df=df.drop(index=1)
print(df)

#Grouping data by a coloums
gro = df.groupby('History')
print(gro['Age'].mean())

#Aggeraging data using the mulitple funcntions
df1 = pd.DataFrame({'id' : [1, 2, 3], 'Age' : ['Alice', 'Bob', 'Charlie']})
df2 = pd.DataFrame({'id' : [1, 2, 4], 'History' : [50000, 60000, 70000]})

# Merging dataframes on a common column
merged_df = pd.merge(df1, df2, on = 'id', how = 'inner')
print(merged_df)

#Joining dataframes
df1 = pd.DataFrame({'Name' : ['Alice','Bob'], 'Age': [25, 30]}, index = [0,1])
df2 = pd.DataFrame({'Science' : ['New York', 'Los Angles']}, index=[0, 2])

#Joining dataframes on their index
joined_df = df1.join(df2, how = 'left')
print(joined_df)
