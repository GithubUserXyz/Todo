import 'package:flutter/material.dart';

import 'my_todo_list_page.dart' show MyListPage;

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
