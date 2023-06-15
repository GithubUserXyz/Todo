import '../entity/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> readAllTodos();
  Future<Todo?> readTodoById(int id);
  Future<bool> createTodo(String title, String description);
  Future<bool> updateTodo(Todo todo);
  Future<bool> deleteTodoById(int id);
}
