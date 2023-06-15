import 'package:flutter_test/flutter_test.dart';
import 'package:grape/model/api/todo_api.dart';
import 'package:grape/model/entity/todo.dart';
import 'package:intl/intl.dart';

void main() {
  test('repository api todo', () async {
    var api = TodoApi();
    await api.readAllTodos();
  });

  test('create todo', () async {
    var api = TodoApi();
    await api.createTodo('test1 title', 'test1 description');
  });

  test('read todo', () async {
    var api = TodoApi();
    Todo? todo = await api.readTodoById(6);
    expect(todo, isNotNull);
    expect(todo, isInstanceOf<Todo>());
  });

  test('update todo', () async {
    var api = TodoApi();
    Todo? todo = await api.readTodoById(6);

    expect(todo, isNotNull);
    expect(todo, isInstanceOf<Todo>());

    var now = DateTime.now();
    String nowStr = DateFormat('yyyyMMddhhmm').format(now);
    String updateTitle = todo!.title + nowStr;
    todo.title = updateTitle;
    await api.updateTodo(todo);

    Todo? todo2 = await api.readTodoById(6);
    expect(todo2, isNotNull);
    expect(todo2, isInstanceOf<Todo>());
    expect(todo2!.title, equals(updateTitle));
  });

  test('delete todo', () async {
    var api = TodoApi();
    await api.deleteTodoById(6);

    Todo? todo = await api.readTodoById(6);
    expect(todo, isNull);
  });
}
