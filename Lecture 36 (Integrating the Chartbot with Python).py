# -*- coding: utf-8 -*-
"""Integrating the chartbot.ipynb

"""

!pip install dash

import pandas as pd
import nltk
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.naive_bayes import MultinomialNB
from sklearn.pipeline import make_pipeline
from sklearn.model_selection import train_test_split
import dash
from dash.dependencies import Input, Output, State
import dash_core_components as dcc
import dash_html_components as html

# Load the dataset
data = pd.read_csv('/dataset.csv')

# Preprocess the data
nltk.download('punkt')
data['Questions'] = data['Questions'].apply(lambda x: ' '.join(nltk.word_tokenize(x.lower())))
X_train, X_test, y_train, y_test = train_test_split(data['Questions'], data['Answers'], test_size=0.2, random_state=42)

# Create and train the model pipeline
model = make_pipeline(TfidfVectorizer(), MultinomialNB())
model.fit(X_train, y_train)

def get_response(question):
    # Tokenize and preprocess the question
    question = ' '.join(nltk.word_tokenize(question.lower()))
    answer = model.predict([question])[0]
    return answer

# Using the Dash App
app = dash.Dash(__name__)

# Define the layout
app.layout = html.Div([
    html.H1("Chatbot", style={'textAlign': 'center'}),
    dcc.Textarea(
        id='user-input',
        value='Type your question here...',
        style={'width': '100%', 'height': 100}
    ),
    html.Button('Submit', id='submit-button', n_clicks=0),
    html.Div(id='chatbot-output', style={'padding': '10px'})
])

# Define callback to update chatbot response
@app.callback(
    Output('chatbot-output', 'children'),
    Input('submit-button', 'n_clicks'),
    State('user-input', 'value')
)
def update_output(n_clicks, value):
    if n_clicks > 0:
        response = get_response(value)
        return response

# Run the app
if __name__ == '__main__':
    app.run_server(debug=True)
