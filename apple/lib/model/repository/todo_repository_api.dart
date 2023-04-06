import 'package:apple/model/api/api_service.dart';
import 'package:apple/model/repository/todo_repository.dart';

import '../entity/todo.dart';

class TodoRepositoryApi extends ApiService implements TodoRepository {
  TodoRepositoryApi();

  @override
  Future<Todo> readTodoById(int id) async {
    // TodoデータをAPIを通じて読み込む処理
    return super.getTodo(id);
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
