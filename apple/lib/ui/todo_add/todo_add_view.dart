import 'package:apple/model/repository/todo_repository_api.dart';
import 'package:apple/ui/todo_add/todo_add_view_model.dart';
import 'package:apple/ui/todo_list/todo_list_view.dart';
import 'package:apple/ui/todo_list/todo_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoAddView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = TodoAddViewModel(TodoRepositoryApi());
    return ChangeNotifierProvider(
      create: (_) => vm,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Todo 追加"),
        ),
        body: _TodoAddPage(),
      ),
    );
  }
}

class _TodoAddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _TodoAddForm();
  }
}

class _TodoAddForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<TodoAddViewModel>(context);
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
          TextField(controller: vm.titleTextFieldController),
          const SizedBox(height: 8),
          const Text(
            'Description:',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 8),
          TextField(controller: vm.descriptionTextFieldController),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                vm.createTodo();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
              },
              child: const Text(
                '追加',
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
