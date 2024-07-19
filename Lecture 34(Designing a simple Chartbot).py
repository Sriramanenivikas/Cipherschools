# -*- coding: utf-8 -*-
"""Designinga chartbot.ipynb

"""

#Prepossing Text Data
import pandas as pd
import nltk

nltk.download('punkt')

# Load the dataset
data = pd.read_csv('/dataset.csv')

# Preprocess the data: tokenize questions and convert to lowercase
data['Questions'] = data['Questions'].apply(lambda x: ' '.join(nltk.word_tokenize(x.lower())))
print(data.head())

#vectorizating the data
from sklearn.feature_extraction.text import TfidfVectorizer
vectorizer  = TfidfVectorizer()
X = vectorizer.fit_transform(data['Questions'])
print(X.shape)

#Training a text classificatiob model
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.pipeline import make_pipeline
from sklearn.model_selection import train_test_split
from sklearn.naive_bayes import MultinomialNB

X_train, X_test, y_train, y_test = train_test_split(data['Questions'], data['Answers'], test_size=0.2, random_state=42)

# Create a model pipeline
model = make_pipeline(TfidfVectorizer(), MultinomialNB())

# Train the model
model.fit(X_train, y_train)

print("Model training complete.")

#Implementing a function to get a chartbot Responces
def get_response(questions):
  questions = ' '.join(nltk.word_tokenize(questions.lower()))
  answers= model.predict([questions])[0]
  return answers
  print(get_response("Full name of laxman")) #consider the below one

import nltk
from sklearn.pipeline import Pipeline

# Make sure to download the necessary resources for NLTK
nltk.download('punkt')


def get_response(question):
    # Tokenize and preprocess the question
    question = ' '.join(nltk.word_tokenize(question.lower()))

    answer = model.predict([question])[0]
    return answer

print(get_response("full name of laxman"))

