import logging
from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS

db = SQLAlchemy()
app = Flask(__name__)
app.config["JSON_AS_ASCII"] = False
# data base
app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///todo.db"
db.init_app(app)
# cors
# flutter側のError: XMLHttpRequest error.対策。
CORS(app)
# logging
logging.basicConfig(level=logging.DEBUG)

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

###############################################################
# todoの一覧を返す
#
@app.get("/api/todos")
def todo_get():
    todos = db.session.execute(db.select(Todo).order_by(Todo.id)).scalars()
    app.logger.debug(todos)
    todos_dict = \
        [
            {'id': t.id, 'title': t.title, 'description': t.description}  for t in todos
        ]
    app.logger.debug(todos_dict)
    # 200 OKステータスコードと一書に返答
    return jsonify(todos_dict), 200

###############################################################
# todo1件の内容をかえす
#
@app.get("/api/todos/<int:id>")
def todo_get_(id):
    todo = db.get_or_404(Todo, id)
    return jsonify(
        {
        "id":todo.id,
        "title": todo.title,
        "description": todo.description
        }
    )

###############################################################
# todoを追加
#
@app.post("/api/todos")
def todo_post():
    # Valication
    app.logger.debug("title "+request.json["title"])
    app.logger.debug("desciption "+request.json["description"])
    # data create
    todo = Todo(
        title=request.json["title"],
        description=request.json["description"],
    )
    db.session.add(todo)
    db.session.commit()
    # return
    return jsonify({
        "id":todo.id,
        "title":todo.title,
        "description":todo.description
        }), 200

###############################################################
# todoを変更
#
@app.put("/api/todos/<int:id>")
def todo_put_(id):
    todo = db.get_or_404(Todo, id)

    todo.title = request.json["title"]
    todo.description = request.json["description"]

    todo.verified = True
    db.session.commit()
    return jsonify(
        {
        "id":todo.id,
        "title":todo.title,
        "description":todo.description
        }
    ), 200

###############################################################
# todoを削除
#
@app.delete("/api/todos/<int:id>")
def todo_delete_(id):
    todo = db.get_or_404(Todo, id)

    db.session.delete(todo)
    db.session.commit()
    return "", 200