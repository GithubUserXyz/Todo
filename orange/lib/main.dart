import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'MyTodoAddPage.dart' show MyTodoAddPage;
import 'MyListPage.dart' show MyListPage;

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
