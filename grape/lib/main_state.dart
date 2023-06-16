import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:grape/model/repository/todo_repository.dart';

import 'model/entity/todo.dart';

class MainState with ChangeNotifier {
  MainState() {
    //_todoRepository = TodoApi();
    _todoRepository = GetIt.I<TodoRepository>();
    readTodos();
  }

  late TodoRepository _todoRepository;
  List<Todo> _todoItems = [];
  List<Todo> get todoItems => _todoItems;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> readTodos() async {
    _startLoading();
    _todoItems = await _todoRepository.readAllTodos();
    _finishLoading();
  }

  Future<void> deleteTodo(int id) async {
    _startLoading();
    await _todoRepository.deleteTodoById(id);
    _todoItems = await _todoRepository.readAllTodos();
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
