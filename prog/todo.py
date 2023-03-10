from flask import Flask, jsonify
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()
app = Flask(__name__)
app.config["JSON_AS_ASCII"] = False
app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///todo.db"
db.init_app(app)

class Todo(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title  = db.Column(db.String, nullable=False)
    description = db.Column(db.String)

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
    return jsonify({
        "id":1,
        "title":"todo title",
        "description":"todo description"
        }), 200

@app.put("/todo")
def todo_put():
    return "<h1>put item</h1>"

@app.delete("/todo")
def todo_delete():
    return "<h1>delete item</h1>"