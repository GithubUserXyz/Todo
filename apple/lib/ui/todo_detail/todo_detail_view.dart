import 'dart:developer';

import 'package:apple/model/repository/todo_repository_api.dart';
import 'package:apple/ui/todo_add/todo_add_view.dart';
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
    return _TodoDetailWidget();
    //return Scaffold(body: Text(vm.todo.title));
  }
}

class _TodoDetailWidget extends StatelessWidget {
  void _navigateAndDisplayTodoEditPage(BuildContext context, Todo todo) async {
    var route = MaterialPageRoute(
      settings: const RouteSettings(name: '/todo_edit'),
      builder: (BuildContext context) => TodoAddView(todo),
    );
    await Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<TodoDetailViewModel>(context);
    final _todo = vm.todo;
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Title:',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            vm.todo.title,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Description:',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            vm.todo.description,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _navigateAndDisplayTodoEditPage(context, _todo);
              },
              child: const Text(
                '変更',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
