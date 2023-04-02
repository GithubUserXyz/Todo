import 'package:apple/ui/todo_list/todo_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = TodoListViewModel();
    return ChangeNotifierProvider(
      create: (_) => vm,
    );
  }
}
