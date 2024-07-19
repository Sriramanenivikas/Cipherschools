# -*- coding: utf-8 -*-
"""chartbot.ipynb

"""

#Tokenizations

import nltk
nltk.download('punkt')
from nltk.tokenize import word_tokenize
text = "Natural Language processing is Fasciating"
tokens = word_tokenize(text)
print(tokens)

#Stemming

from nltk.stem import PorterStemmer
stemmer = PorterStemmer()
words = ['Running','ran','Run']
stems = [stemmer.stem(word) for word in words]
print(stems)

#Lemmatizations
from nltk.stem import WordNetLemmatizer
import nltk
nltk.download('wordnet')
lemmatizer = WordNetLemmatizer()
words = ['Running', 'ran', 'Run']
le = [lemmatizer.lemmatize(word, pos='v') for word in words]
print(le)

#stop words
from nltk.corpus import stopwords
nltk.download('stopwords')

stop_words = set(stopwords.words('english'))
filer = [word for word in tokens if word.lower() not in stop_words]
print(filer)

