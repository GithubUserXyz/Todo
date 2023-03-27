import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:orange/main.dart';

class MyTodoInfoPage extends StatefulWidget {
  const MyTodoInfoPage({Key? key}) : super(key: key);

  @override
  State<MyTodoInfoPage> createState() => _MyTodoInfoPage();
}

class _MyTodoInfoPage extends State<MyTodoInfoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop('');
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Todo 内容'),
        ),
        body: Container(
          // まわりに余白を追加
          padding: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[],
          ),
        ),
      ),
    );
  }
}
