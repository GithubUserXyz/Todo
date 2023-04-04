import 'package:apple/model/repository/todo_repository.dart';

import '../entity/todo.dart';

class TodoRepositoryApi implements TodoRepository {
  TodoRepositoryApi();
  @override
  Future<Todo> readTodoById(int id) async {
    // TodoデータをAPIを通じて読み込む処理
    // 暫定
    return Todo(id: 1, title: "test title", description: "test");
  }

  @override
  Future<void> createTodo(Todo todo) async {
    // TodoデータをAPIを通じて登録する処理
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    // TodoデータをAPIを通じて変更する処理
  }

  @override
  Future<void> deleteTodoById(int id) async {
    // TodoデータをAPIを通じて消去する処理
  }
}
