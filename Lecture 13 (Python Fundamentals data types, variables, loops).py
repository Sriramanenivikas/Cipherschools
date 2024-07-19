# -*- coding: utf-8 -*-


#variables
name="Vamsi Krishna"
age =21
print(name)
print(age)
#data types
print(abs(age))
print(bin(age))
print(hex(age))
print(pow(age,2))
print(divmod(age,2))
print(round(age))
b=12.5
print(int(b))
c="45.6"
print(float(c))
print(b.is_integer())
#string
l="Hello, World!"
print(l.upper())
print(l.lower())
print(l.split())
print(l.replace("World!", "EveryOne"))
print(len(l))
print(l.find("World!"))
#list
f=["apple","banana","cherry"]
print(f.append("orange"))
print(f.extend(["graphs","mango"]))
f.remove("apple")
f.pop()
print(f.sort())
print(f.index("banana"))
print("apple" in f)
#Tuple
t=(10,12.0)
print(t.count(10))
print(t.index(12.0))
print(len(t))
#convert tuple to list
l=list(t)
l="hi"
t=tuple(l)
print(t)
#dictionary

#dictionary
person={"name": "laxman","age":21}
print(person.keys())
print(person.values())
print(person.items())
print(person.get("name"))
person.update({"age" : 40})
print(person)
person.pop("age")
print(len(person))

#set
s={1,2,3,4}
print(s)
print(len(s))
s.add(7)
print(s)
s.update({10,11,18})
print(s)
s.remove(10)

print(s)

#Boolean
a=True
print(int(a))
print(bool(a))
print(bool("Hello!"))
print(a and False)
print(a or False)
print(not a)

#conditional Statements
#t=input("Enter your age: ")
#print(t)
age=20
if age<18:
  print("Minor")
elif age>=18 and age<65:
  print("Adult")
else:
  print("Senior")

#check even or odd
n = int(input("Enter a Number: "))
print(n)
if n % 2 == 0:
    print("Even Number")
else:
    print("Odd Number")

#Grade Evaluation
s=85
if s>= 90:
  print("Grade: A")
elif s>= 80:
  print("Grade: B")
elif s>= 70:
  print("Grade: C")
elif s>= 60:
  print("Grade: D")
else:
  print("Grade: F")

#Temperature Check
t=30
if t >=30:
  print("Hot day")
elif t >=20:
  print("Nice day")
else:
  print("Coll day")

#Nested Conditional statements
weight = 80
height = 1.75

bmi = weight / (height ** 2)

if bmi < 18.5:
  print("Underweight")
else:
  if bmi < 24.9:
    print("Normal weight")
  else:
    if bmi < 29.9:
      print("Overweight")
    else:
      print("Obesity")

#loops
for i in range(5):
  print(i)

#using the string
h = "Hello"
for char in h:
  print(char)

#Iterating over a Dictionary

person = {"name" : "John", "age" : 30, "city" : "new York"}

for key,value in person.items():
  print(f"{key} : {value}")

#Using the 'range()' function with step
for i in range(0,10,2):
  print(i)

#nested for loops
for i in  range(3):
  for j in range(2):
    print(f"i = {i}, j = {j}")

#using the 'enumerate(); function
fruits = ["apple", "banana"]
for index, fruit in enumerate(fruits):
  print(f"Index : {index}, Fruit : {fruit}")

#while loops
count = 0
while count < 5:
  print(count)
  count += 1

#using the break with loops
count = 0
while True:
  print(count)
  count += 1
  if count >= 5:
    break

#while loops with continue
count =0
while count < 10:
  count += 1
  if count % 2 == 0:
      continue
  print(count)

#countdown
countdown = 5
while countdown > 0:
  print(countdown)
  countdown -= 1
print("Blast Off!")

#password validation
password = ""
while len(password) < 8:
  password = input("Enter a password (must contain 8 characteers)")
  if len(password) < 8:
    print("Password too short . Try Again ")
print("password accepted")
