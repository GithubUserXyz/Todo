import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'package:apple/model/entity/todo.dart';

class ApiService {
  static const String api_url = '127.0.0.1:5000';

  /// Todoの一覧をListでかえす
  Future<List<Todo>> getTodoList() async {
    var response = await http.get(Uri.http(api_url, 'api/todos'));
    // utf8は文字化け対策
    var jsonArray = jsonDecode(utf8.decode(response.bodyBytes));
    //log(jsonArray.toString());
    // jsonArrayには"[{id:1, title: ...},{id:2, title:...}]
    // のような文字列が入ってる
    // mac<Todo>のようにしないと、List<dynamic>となりList<Todo>に入らず、
    // エラーとなる。
    List<Todo> todoList = jsonArray.map<Todo>((i) => Todo.fromJson(i)).toList();
    //todoList.forEach((element) => {log(element.toString())});
    return todoList;
  }

  /// idで指定されたTodoを取得する
  Future<Todo> getTodoById(int id) async {
    var response = await http.get(Uri.http(api_url, 'api/todos/$id'));
    // utf8は文字化け対策
    var jsonRes = jsonDecode(utf8.decode(response.bodyBytes));
    // Todoをかえす
    return Todo.fromJson(jsonRes);
  }

  Future<Todo> putTodo(Todo todo) async {
    log('updateTodo');
    Map<String, String> headers = {'content-type': 'application/json'};
    var body = jsonEncode({
      'title': todo.title,
      'description': todo.description,
    });
    final response = await http.put(
      Uri.http('127.0.0.1:5000', 'api/todos/${todo.id}'),
      headers: headers,
      body: body,
    );
    var jsonRes = jsonDecode(utf8.decode(response.bodyBytes));
    //var jsonRes = jsonDecode(response.body);
    log(jsonRes.toString());
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to create Todo');
    }
    return Todo.fromJson(jsonRes);
  }

  Future<void> deleteTodo() async {}

  /// titleとdescriptionをapiを通じて追加する
  Future<Todo> postTodo(String title, String description) async {
    Map<String, String> headers = {'content-type': 'application/json'};
    var body = jsonEncode({'title': title, 'description': description});
    final response = await http.post(
      Uri.http(api_url, 'api/todos'),
      headers: headers,
      body: body,
    );
    var jsonRes = jsonDecode(utf8.decode(response.bodyBytes));
    //var jsonRes = jsonDecode(response.body);
    log(jsonRes.toString());
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to Create Todo');
    }
    return Todo.fromJson(jsonRes);
  }
}
