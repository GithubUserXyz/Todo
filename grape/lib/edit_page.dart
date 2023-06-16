import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:grape/model/repository/todo_repository.dart';
import 'package:provider/provider.dart';

import 'main_state.dart';
import 'model/entity/todo.dart';

class _FormState extends ChangeNotifier {
  late Todo? todo;
  late bool isNew;
  late String screenName;

  late TextEditingController _titleField;
  late TextEditingController _descriptionField;

  bool _isSending = false;
  bool get isSending => _isSending;

  var todoApi = GetIt.I<TodoRepository>();

  _FormState({required this.todo}) {
    _titleField = TextEditingController();
    _descriptionField = TextEditingController();

    if (todo == null) {
      screenName = 'Add';
      isNew = true;
    } else {
      screenName = 'Edit';
      isNew = false;
      _titleField.text = todo!.title;
      _descriptionField.text = todo!.description;
    }
  }

  TextEditingController get titleField => _titleField;
  TextEditingController get descriptionField => _descriptionField;

  Future<void> createTodo() async {
    _startSending();
    await todoApi.createTodo(titleField.text, descriptionField.text);
    _finishSending();
  }

  Future<void> updateTodo() async {
    _startSending();
    if (todo != null) {
      todo!.title = _titleField.text;
      todo!.description = _descriptionField.text;
      await todoApi.updateTodo(todo!);
    }
    _finishSending();
  }

  void _startSending() {
    _isSending = true;
    notifyListeners();
  }

  void _finishSending() {
    _isSending = false;
    notifyListeners();
  }
}

// ignore: must_be_immutable
class EditPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  static String routeName = 'editTodo';

  late _FormState _formState;

  EditPage({super.key, Todo? todo}) {
    _formState = _FormState(todo: todo);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _formState,
      child: Scaffold(
        appBar: AppBar(title: Text(_formState.screenName)),
        body: Center(
          child: _getForm(context),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (_formState.isNew) {
              await _formState.createTodo();
            } else {
              await _formState.updateTodo();
            }
            await GetIt.I<MainState>().readTodos();
            // ignore: use_build_context_synchronously
            context.pop('/');
          },
          child: Icon(_formState.isNew ? Icons.add : Icons.edit),
        ),
      ),
    );
  }

  Widget _getForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: _getFormWidgets(context),
      ),
    );
  }

  List<Widget> _getFormWidgets(BuildContext context) {
    List<Widget> formWidget = [];

    formWidget.add(
      TextFormField(
        controller: _formState.titleField,
        decoration:
            const InputDecoration(labelText: 'Title', hintText: 'Title'),
      ),
    );

    formWidget.add(
      TextFormField(
        controller: _formState.descriptionField,
        decoration: const InputDecoration(
            labelText: 'Description', hintText: 'Description'),
      ),
    );

    return formWidget;
  }
}
