import 'package:apple/model/entity/todo.dart';
import 'package:apple/model/repository/todo_repository_api.dart';
import 'package:apple/ui/todo_add/todo_add_view_model.dart';
import 'package:apple/ui/todo_list/todo_list_view.dart';
import 'package:apple/ui/todo_list/todo_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoAddView extends StatelessWidget {
  late final TodoAddViewModel vm;
  // ignore: use_key_in_widget_constructors
  TodoAddView([Todo? todo]) {
    if (todo != null) {
      // 編集としての動作となる
      vm = TodoAddViewModel(TodoRepositoryApi(), todo);
    } else {
      // 新規作成の動作となる
      vm = TodoAddViewModel(TodoRepositoryApi());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoAddViewModel>.value(
      value: vm,
      child: Scaffold(
        appBar: AppBar(
          title: Text(vm.isNew ? "Todo 追加" : 'Todo 編集'),
        ),
        body: _TodoAddPage(),
      ),
    );
  }
}

class _TodoAddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _TodoForm();
  }
}

class _TodoForm extends StatelessWidget {
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
                if (vm.isNew == true) {
                  // 新規作成時の動作
                  vm.createTodo();
                } else {
                  // 編集時の動作
                  vm.updateTodo();
                }
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
              },
              child: Text(
                vm.isNew ? '追加' : '変更',
                style: const TextStyle(
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
