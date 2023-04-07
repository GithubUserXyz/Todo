import 'package:apple/model/entity/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> readAllTodo();
  Future<Todo> readTodoById(int id);
  Future<void> createTodo(Todo todo);
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodoById(int id);
}
