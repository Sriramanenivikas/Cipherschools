# -*- coding: utf-8 -*-
"""Untitled3.ipynb

"""

#creating a numpy array from a list
import numpy as np
#creation of 1D array
arr1=np.array([1,2,3,4,5,56,7])
print(arr1)
#creation of 2D arrau
arr2 = np.array([[1,2,3],[4,5,6]])
print(arr2)

#creation an zeros by array
zero= np.zeros((3,4))
print(zero)

#creation an ones by array
ones= np.ones((3,4))
print(ones)

#array with a range of value
range_arr = np.arange(10,20,2)
print(range_arr)

#creation of array with the random values
random_arr=np.random.rand(3,3)
print(random_arr)

#Basic Array opertion elements wise operation
arr = np.array([1,2,3,4,5,6])
print(arr+2)
print(arr*2)
print(arr-1)

arr = np.array([1,2,3,4,5,6])
for i in arr:
  print(i+2)

print(arr/2)

#Mathematical Function in array Operations
print(np.sqrt(arr))
print(np.exp(arr))
print(np.log(arr))
print(np.sin(arr))

#Indexing and Slicing Indexing
print(arr[0])
print(arr[4])

#Slicing values
print(arr[1:4])
print(arr[:3])
print(arr[2:])

#Boolean Indexing
arr = np.array([1,2,3,4,5])
print(arr[arr>3])
#fancy indexing value
indi = [0,2,4]
print(arr[indi])

#Reshaping of array
arr=np.array([[1,2,3],[4,5,6]])
resh=arr.reshape((3,2))
print(resh)

#Transporting array
tras=np.transpose(arr)
print(arr)
tra=arr.T
print(tra)

#Aggregation Function like sum,mean
print(np.sum(arr))
print(np.sum(arr, axis=0))#along coloums
print(np.sum(arr, axis=1))#along rows
print(np.mean(arr))
print(np.argmin(arr))
print(np.argmax(arr))

