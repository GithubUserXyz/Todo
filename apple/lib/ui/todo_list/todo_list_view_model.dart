import 'package:flutter/material.dart';

import 'package:apple/model/entity/todo.dart';

class TodoListViewModel extends ChangeNotifier {
  List<Todo> _todos = [];
}
