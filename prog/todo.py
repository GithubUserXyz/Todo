from flask import Flask

app = Flask(__name__)

@app.route("/")
def todo():
    return "<h1>Todo</h1>"

@app.route("/about")
def about():
    return "<h1>About</h1>"