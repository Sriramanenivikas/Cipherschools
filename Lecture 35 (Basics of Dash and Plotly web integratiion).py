# -*- coding: utf-8 -*-
"""Basics of Dash.ipynb

"""

pip install dash

#Using the Dash App
import dash
app= dash.Dash(__name__)

#Defining the layout
from dash import dcc, html
#Define the layout
app.layout = html.Div([
    html.H1("My Dash App", style={'textAlign': 'center'}),
    dcc.Input(id="input-box", type='text', placeholder="Type something..."),
    html.Button('Submit', id='button'),
    html.Div(id='output-div')
])

#Call to update the output
from dash.dependencies import Input, Output

# Define callback to update output
@app.callback(
    Output('output-div', 'children'),
    Input('button', 'n_clicks'),
    [dash.dependencies.State('input-box', 'value')]
)
def update_output(n_clicks, value):
    if n_clicks is not None:
        return f'You have entered: {value}'
    return ''

#Running the App
if __name__ == ' __main__':
  app.run_server(debug=True)

#Example: To Adding the text Area
app.layout = html.Div([
    html.H1("Chatbot", style={'textAlign': 'center'}),
    dcc.Textarea(
        id='user-input',
        placeholder='Type your question here...',
        style={'width': '100%', 'height': 100}
    ),
    html.Button("Submit", id="submit-button", n_clicks=0),
    html.Div(id="chatbot-output", style={'padding': '10px'})
])

#Example: Creating a Chartbot Responce
#Define callback to update chartbot response

@app.callback(
    Output('chatbot-output', 'children'),
    Input('submit-button', 'n_clicks'),
    [dash.dependencies.State('user-input', 'value')]
)
def update_output(n_clicks, user_input):
    if n_clicks is not None and n_clicks > 0:
        return html.Div([
            html.P(f"You: {user_input}", style={'margin': '10px'}),
            html.P(f"Bot: I am training now, ask something else.", style={'margin': '10px', 'backgroundColor': '#fefefe', 'padding': '10px'})
        ])
    return "Ask me something!"
