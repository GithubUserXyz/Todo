import 'package:flutter/material.dart';

import 'package:apple/model/entity/todo.dart';

class TodoListViewModel extends ChangeNotifier {
  List<Todo> _todos = [];
  bool _isLoading = false;

  TodoListViewModel() {}

  // getter
  List<Todo> get todos => _todos;
  bool get isLoading => _isLoading;
}
