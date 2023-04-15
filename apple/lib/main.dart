import 'package:apple/model/entity/todo.dart';
import 'package:apple/model/repository/todo_repository_api.dart';
import 'package:apple/ui/todo_add/todo_add_view_model.dart';
import 'package:apple/ui/todo_detail/todo_detail_view.dart';
import 'package:apple/ui/todo_list/todo_list_view.dart';
import 'package:apple/ui/todo_list/todo_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_driver/driver_extension.dart';

void main() {
  //enableFlutterDriverExtension();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      title: 'Todo',
      routes: <String, WidgetBuilder>{
        '/': (context) => TodoListView(),
      },
    );
  }
}
