import 'package:apple/model/entity/todo.dart';
import 'package:apple/model/repository/todo_repository.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class TodoAddViewModel extends ChangeNotifier {
  TodoAddViewModel(this._repository) {
    _titleTextFieldController = TextEditingController();
    _descriptionTextFieldController = TextEditingController();
  }

  late TextEditingController _titleTextFieldController;
  TextEditingController get titleTextFieldController =>
      _titleTextFieldController;

  late TextEditingController _descriptionTextFieldController;
  TextEditingController get descriptionTextFieldController =>
      _descriptionTextFieldController;

  final TodoRepository _repository;

  bool _isSending = false;
  bool get isSending => _isSending;

  void createTodo() async {
    _startCreating();
    await _repository.createTodo(
      title: _titleTextFieldController.text,
      description: _descriptionTextFieldController.text,
    );
    _finishCreating();
  }

  void _startCreating() {
    _isSending = true;
    notifyListeners();
  }

  void _finishCreating() {
    _isSending = false;
    notifyListeners();
  }
}
