import 'dart:convert';
//import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../entity/todo.dart';
import '../repository/todo_repository.dart';

class TodoApi implements TodoRepository {
  @override
  Future<List<Todo>> readAllTodos() async {
    var response = await http.get(Uri.http('127.0.0.1:5000', 'api/todos'));
    var jsonRes = jsonDecode(utf8.decode(response.bodyBytes));
    //debugPrint(jsonRes.map((map) => Todo.fromJson(map)).toList().toString());

    return jsonRes.map<Todo>((map) => Todo.fromJson(map)).toList();
  }

  @override
  Future<Todo?> readTodoById(int id) async {
    var response = await http.get(Uri.http('127.0.0.1:5000', 'api/todos/$id'));
    if (response.statusCode == 200) {
      var jsonRes = jsonDecode(utf8.decode(response.bodyBytes));
      return Todo.fromJson(jsonRes);
    } else {
      return null;
    }
  }

  @override
  Future<bool> createTodo(String title, String description) async {
    Map<String, String> headers = {'content-type': 'application/json'};
    var body = jsonEncode({
      'title': title,
      'description': description,
    });
    final response = await http.post(
      Uri.http('127.0.0.1:5000', 'api/todos'),
      headers: headers,
      body: body,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> updateTodo(Todo todo) async {
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
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> deleteTodoById(int id) async {
    final response =
        await http.delete(Uri.http('127.0.0.1:5000', 'api/todos/$id'));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
      //throw Exception('Failed to delete Todo');
    }
  }
}
