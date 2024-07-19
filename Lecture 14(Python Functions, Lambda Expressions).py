# -*- coding: utf-8 -*-
"""Untitled2.ipynb

"""

#simple function
def add_num(a, b):
  """Function to add two number"""
  return a + b
  #calling the function
print(add_num(4, 8))

def sqr(a):
  print(a*a)
a=int(input("Enter a value of a: "))
sqr(a)

def sqr(a):
  return a*a
a=int(input("Enter a value of a: "))
sqr(a)

def squ(a):
  return a**2
a=int(input("Enter a value of a : "))
c=squ(a)
print("c= ",c)

#using defult argumemnts
def greet(name, message="Hello"):
  """  function to greet a person with defult message"""
  return f"{message}, {name}!"

  #calling a function
print(greet("laxman"))
print(greet("reddy","babu"))

#function with variable length arguments
def sum_all(*args):
  """ function to sum all given arguments"""
  return sum(args)
#calling of function
print(sum_all(1,2,3,45,6,79,8))

#function with keyword Arguments
def dis_info(**kwargs):
  """function to dispaly information using keyword arguments"""
  for key, value in kwargs.items():
    print(f"{key}: {value}")

    #calling the funtion
dis_info(name="laxman reddy", age=21, city="India")

#higer order function
#function using the multiple function
def apply_fun(fun, x, y):
  """ Function to apply fucntion to given arguments"""
  return fun(x, y)
def mult(a,b):
  return a*b
#calling a function
print(apply_fun(mult, 6, 7))

#lambda expression
sqr = lambda x: x*x
print(sqr(8))

#lambda expression in maping
num= [1,2,3,4,5,6]
sqr = list(map(lambda x: x*x,num))
print(sqr)

#using the filter number
num = [1,2,3,4,5,6]
even_num=list(filter(lambda x: x%2 == 0,num))
print(even_num)

#using the sorted function
num = [4,8,9,7,6,8,15,48,89]
sort_num=list(sorted(num))
print(sort_num)

students = [("Alice", 25), ("Bob", 20), ("Charlie", 23)]
sorted_students = sorted(students, key = lambda student: student[1])

print(sorted_students)

#Error Handling using the try except else and finally key word
try:
  result =10/0
except ZeroDivisionError:
  print("Cannot divide by zero!")

try:
  result =10/2
except ZeroDivisionError:
  print("Cannot divide by zero!")
else:
  print("we can divide successfully")

#using the finally keyword
try:
  result =10/2
except ZeroDivisionError:
  print("Cannot divide by zero!")
finally:
  print("Execution completed.")

#Handing mulitple exception
try:
  num = int(input("Enter a Number: "))
  res = 10/num
except ValueError:
  print("Invalid input")
except ZeroDivisionError:
  print("Number cannot divide by zero! ")

def check_positive(number):
  if number <= 0:
    raise ValueError("Number must be positive")
  else:
    print(number)

try:
  check_positive(-5)
except ValueError as e:
  print(e)
