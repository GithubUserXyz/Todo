import 'package:apple/model/entity/todo.dart';
import 'package:apple/model/repository/todo_repository.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class TodoAddViewModel extends ChangeNotifier {
  TodoAddViewModel(this._repository, [Todo? todo]) {
    _titleTextFieldController = TextEditingController();
    _descriptionTextFieldController = TextEditingController();

    /// 引数でTodo(todo)を受け取って、
    /// 実際に引数として受け取らなければ、新規作成、
    /// 　　　　　　　　受け取れば、編集、
    /// というような動作。
    if (todo == null) {
      // 新規作成としての動作
      _isNew = true;
    } else {
      // 編集としての動作
      _isNew = false;
      _todo = todo;
    }
  }

  late TextEditingController _titleTextFieldController;
  TextEditingController get titleTextFieldController =>
      _titleTextFieldController;

  late TextEditingController _descriptionTextFieldController;
  TextEditingController get descriptionTextFieldController =>
      _descriptionTextFieldController;

  final TodoRepository _repository;

  Todo? _todo;
  Todo? get todo => _todo;

  bool _isNew = true;
  bool get isNew => _isNew;

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
