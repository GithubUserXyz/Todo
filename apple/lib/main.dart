import 'package:apple/ui/todo_list/todo_list_view.dart';
import 'package:flutter/material.dart';

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
