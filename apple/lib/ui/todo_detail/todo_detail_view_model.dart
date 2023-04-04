import 'package:apple/model/repository/todo_repository.dart';
import 'package:apple/ui/todo_detail/todo_detail_view.dart';
import 'package:flutter/material.dart';

import '../../model/entity/todo.dart';
import 'package:apple/ui/todo_detail/todo_detail_view.dart';

class TodoDetailViewModel extends ChangeNotifier {
  TodoDetailViewModel(Todo todo, this._repository) {
    _todo = todo;
    _isNew = (todo == null);
    notifyListeners();
  }

  final TodoRepository _repository;
  late Todo _todo;
  bool _isLoading = false;
  bool _isNew = false;

  Todo initTodo() {
    return Todo(id: -1, title: "", description: "");
  }
}
