# -*- coding: utf-8 -*-
"""Correlation.ipynb

"""

#Correaltion
import pandas as pd
import numpy as np
np.random.seed(42)
d={
    'age': np.random.normal(30,10,100).astype(int),
    'Annual Income': np.random.normal(50,20,100).astype(int),
    'Spending Score ':np.random.randint(1,100,100),
    'Year with Company':  np.random.normal(5,2,100).astype(int),
}
df=pd.DataFrame(d)
df

!pip install tabulate
from tabulate import tabulate

c=df.corr()
#Printing correational Matrix
print(tabulate(c,headers='keys',tablefmt='grid',numalign='right',floatfmt='.2f'))

