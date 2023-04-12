import 'package:apple/model/entity/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> readAllTodo();
  Future<Todo> readTodoById(int id);
  Future<Todo> createTodo({title = String, description = String});
  Future<Todo> updateTodo(Todo todo);
  Future<void> deleteTodoById(int id);
}
