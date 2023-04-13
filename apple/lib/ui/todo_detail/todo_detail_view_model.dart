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
  Todo get todo => _todo;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isNew = false;
  bool get isNew => _isNew;

  void readTodo(int id) async {
    _startLoading();
    _todo = await _repository.readTodoById(id);
    _finishLoading();
  }

  void deleteTodo(int id) async {
    _startLoading();
    await _repository.deleteTodoById(id);
    _finishLoading();
  }

  void _startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void _finishLoading() {
    _isLoading = false;
    notifyListeners();
  }
}
