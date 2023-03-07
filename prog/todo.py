from flask import Flask

app = Flask(__name__)

@app.route("/")
def root():
    return "<h1>Todo</h1>"

@app.route("/about")
def about():
    return "<h1>About</h1>"

@app.get("/todo")
def todo_get():
    return "<h1>get item</h1>"

@app.post("/todo")
def todo_post():
    return "<h1>post item</h1>"

@app.put("/todo")
def todo_put():
    return "<h1>put item</h1>"

@app.delete("/todo")
def todo_delete():
    return "<h1>delete item</h1>"