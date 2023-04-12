import 'package:apple/model/api/api_service.dart';
import 'package:apple/model/repository/todo_repository.dart';

import '../entity/todo.dart';

class TodoRepositoryApi extends ApiService implements TodoRepository {
  TodoRepositoryApi();

  @override
  Future<List<Todo>> readAllTodo() async {
    // TodoデータをAPIを通じてすべて読み込む処理
    return super.getTodoList();
  }

  @override
  Future<Todo> readTodoById(int id) async {
    // TodoデータをAPIを通じて読み込む処理
    return super.getTodoById(id);
  }

  @override
  Future<Todo> createTodo({title = String, description = String}) async {
    // TodoデータをAPIを通じて登録する処理
    return super.postTodo(title, description);
  }

  @override
  Future<Todo> updateTodo(Todo todo) async {
    // TodoデータをAPIを通じて変更する処理
    return super.putTodo(todo);
  }

  @override
  Future<void> deleteTodoById(int id) async {
    // TodoデータをAPIを通じて消去する処理
  }
}
