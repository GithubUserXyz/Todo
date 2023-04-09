import 'package:apple/model/repository/todo_repository.dart';
import 'package:flutter/material.dart';

class TodoAddViewModel extends ChangeNotifier {
  TodoAddViewModel(this._repository) {}

  final TodoRepository _repository;
}
