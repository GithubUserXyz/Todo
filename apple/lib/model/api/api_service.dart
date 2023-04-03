import 'package:apple/model/entity/todo.dart';

class ApiService {
  Future<Todo> getTodo() async {
    // 暫定
    return Todo(id: 1, title: "", description: "");
  }

  Future<void> putTodo() async {}
  Future<void> deleteTodo() async {}
  Future<void> post() async {}
}
