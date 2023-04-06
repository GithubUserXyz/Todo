import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:apple/model/entity/todo.dart';

class ApiService {
  static const String api_url = '127.0.0.1:5000';
  Future<Todo> getTodo(int id) async {
    var response = await http.get(Uri.http(api_url, 'api/todos/$id'));
    // utf8は文字化け対策
    var jsonRes = jsonDecode(utf8.decode(response.bodyBytes));
    // Todoをかえす
    return Todo.fromJson(jsonRes);
  }

  Future<void> putTodo() async {}
  Future<void> deleteTodo() async {}
  Future<void> post() async {}
}
