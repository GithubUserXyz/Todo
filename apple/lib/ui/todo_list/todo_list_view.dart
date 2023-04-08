import 'dart:developer';

import 'package:apple/model/repository/todo_repository_api.dart';
import 'package:apple/ui/todo_detail/todo_detail_view.dart';
import 'package:apple/ui/todo_list/todo_list_view_model.dart';
import 'package:apple/model/entity/todo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoListView extends StatelessWidget {
  const TodoListView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = TodoListViewModel(TodoRepositoryApi());
    final content = _TodoListPage();
    return ChangeNotifierProvider(
      create: (_) => vm,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Todo 一覧'),
        ),
        body: content,
      ),
    );
  }
}

/// todoを一覧でかえす
class _TodoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<TodoListViewModel>(context);

    if (vm.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (vm.todos.isEmpty) {
      return const Center(child: Text('todo list is empty.'));
    }

    return ListView.builder(
      itemCount: vm.todos.length,
      itemBuilder: (context, index) {
        return _buildTodoCard(context, vm.todos[index]);
      },
    );
  }

  Widget _buildTodoCard(BuildContext context, Todo todo) {
    return GestureDetector(
      onTap: () {
        log("'${todo.title}' tapped.");
        _navigateAndDisplayTodoDetailPage(context, todo);
      },
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(todo.title),
              subtitle: Text(todo.description),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateAndDisplayTodoDetailPage(BuildContext context, Todo todo) {
    var route = MaterialPageRoute(
      settings: const RouteSettings(name: '/todo_detail'),
      builder: (BuildContext context) => TodoDetailView(todo: todo),
    );
    Navigator.push(context, route);
  }
}
