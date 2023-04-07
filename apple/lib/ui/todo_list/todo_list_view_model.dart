import 'package:apple/model/repository/todo_repository.dart';
import 'package:flutter/material.dart';

import 'package:apple/model/entity/todo.dart';

class TodoListViewModel extends ChangeNotifier {
  TodoListViewModel(this._repository) {
    readTodos();
  }
  final TodoRepository _repository;

  // 読み込んだTodoの一覧を格納する。
  List<Todo> _todos = [];
  List<Todo> get todos => _todos;
  // 読み込み中かどうか
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// Todoの一覧を読み込む処理
  void readTodos() async {
    _startLoading();
    _todos = await _repository.readAllTodo();
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
