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
}
