from flask import Flask, jsonify

app = Flask(__name__)
app.config["JSON_AS_ASCII"] = False

@app.route("/")
def root():
    return "<h1>Todo</h1>"

@app.route("/about")
def about():
    return "<h1>About</h1>"

@app.get("/todo")
def todo_get():
    # 200 OKステータスコードと一書に返答
    return jsonify({"title":"todo title"}), 200

@app.post("/todo")
def todo_post():
    return "<h1>post item</h1>"

@app.put("/todo")
def todo_put():
    return "<h1>put item</h1>"

@app.delete("/todo")
def todo_delete():
    return "<h1>delete item</h1>"