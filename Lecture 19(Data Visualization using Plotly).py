# -*- coding: utf-8 -*-
"""Untitled5.ipynb

"""

#Installation
import pandas as pd
#load the dataset
df=pd.read_csv('/marksheet.csv')
print(df.head())

#creation of line plots
import plotly.express as px
#creation of lineplot
fig = px.line(df, x='id', y='Science',title='Science marks with id',markers=True)
fig.show()

#creation of bar plots
fig = px.bar(df, x='id', y='Science',title='Science marks with id',color='id')
fig.show()

#scatter plots
fig = px.scatter(df, x='id', y='Science',title='Science marks with id',color='id',)
fig.show()

#creation of histrogram
fig = px.histogram(df, x='id', y='Science',title='Science marks with id', nbins=4)
fig.show()

#creation of pie chart
fig = px.pie(df, values='id', names='Name',title='Names with id')
fig.show()

#creation of intractive line plots
fig = px.line(df, x='id', y='Science',title='Science marks with id',color='id', markers=True)
fig.show()

import plotly.express as px
import pandas as pd

# Sample data
d = {
    'City': ['New York', 'Los Angeles', 'Chicago', 'Houston', 'Phoenix'],
    'State': ['NY', 'CA', 'IL', 'TX', 'AZ'],
    'Population': [12345, 14789, 145689, 45689, 78963]
}

# Creating the dataframe
df = pd.DataFrame(d)

# Creating a geographical map
fig = px.choropleth(
    df,
    locations='State',
    locationmode='USA-states',
    color='Population',
    scope='usa',
    title='Population by State'
)

fig.show()
