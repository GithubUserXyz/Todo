import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'my_todo_add_page.dart' show MyTodoAddPage;
import 'my_todo_list_page.dart' show MyListPage;
import 'my_todo_info_page.dart' show MyTodoInfoPage;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      //theme: ThemeData(fontFamily: 'NotoSansJP'),
      home: MyListPage(),
    );
  }
}
