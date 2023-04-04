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
      child: _TodoDetailPage(),
    );
  }
}

class _TodoDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<TodoDetailViewModel>(context);

    return Scaffold(body: Text("todo_detail_view.dart"));
  }
}
