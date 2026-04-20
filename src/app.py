#!/usr/bin/env python3

from flask import Flask, request

app = Flask(__name__)

@app.route("/", methods=["GET"])
def main():
    return '''
        <h1>Echo Form</h1>
        <form action="/echo_user_input" method="POST">
            <input type="text" name="user_input" placeholder="Type something" />
            <button type="submit">Submit!</button>
        </form>
    '''

@app.route("/echo_user_input", methods=["POST"])
def echo_user_input():
    user_input = request.form.get("user_input", "")
    return f"<h1>You entered:</h1><p>{user_input}</p>"
