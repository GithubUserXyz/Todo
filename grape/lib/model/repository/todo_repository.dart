import '../entity/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> readAllTodos();
}
