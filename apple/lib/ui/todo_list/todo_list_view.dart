import 'package:apple/model/repository/todo_repository_api.dart';
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
        var todo = vm.todos[index];
        return Text(todo.title);
      },
    );
  }

  Widget _buildTodoCard(BuildContext context, Todo todo) {
    return Card(
      child: Text(todo.title),
    );
  }
}
