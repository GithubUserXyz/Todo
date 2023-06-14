import 'package:flutter_test/flutter_test.dart';
import 'package:grape/model/api/todo_api.dart';

void main() {
  test('repository api todo', () async {
    var api = TodoApi();
    api.readAllTodos();
  });
}
