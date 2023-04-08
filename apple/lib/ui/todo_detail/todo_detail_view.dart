import 'dart:developer';

import 'package:apple/model/repository/todo_repository_api.dart';
import 'package:apple/ui/todo_detail/todo_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../model/entity/todo.dart';
import 'package:apple/ui/todo_detail/todo_detail_view_model.dart';
import 'package:apple/model/repository/todo_repository_api.dart';

class TodoDetailView extends StatelessWidget {
  TodoDetailView({required this.todo});
  Todo todo;

  @override
  Widget build(BuildContext context) {
    final vm = TodoDetailViewModel(todo, TodoRepositoryApi());
    return ChangeNotifierProvider(
      create: (_) => vm,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Todo 詳細'),
        ),
        body: _TodoDetailPage(),
      ),
      //child: _TodoDetailPage(),
    );
  }
}

class _TodoDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<TodoDetailViewModel>(context);
    if (vm.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(body: Text(vm.todo.title));
  }
}
