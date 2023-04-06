import 'package:apple/model/entity/todo.dart';

abstract class TodoRepository {
  Future<Todo> readTodoById(int id);
  Future<void> createTodo(Todo todo);
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodoById(int id);
}