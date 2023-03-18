import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyListPage(),
    );
  }
}

class MyListPage extends StatefulWidget {
  const MyListPage({Key? key}) : super(key: key);

  @override
  State<MyListPage> createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  List todo_items = [];

  Future<void> getTodo() async {
    log('getTodo()');
    var response = await http.get(Uri.http('127.0.0.1:5000', 'api/todos'));
    var jsonRes = jsonDecode(response.body);
    log(jsonRes.toString());
    setState(() {
      todo_items = jsonRes;
    });
  }

  @override
  void initState() {
    super.initState();
    log("initState");
    getTodo();
    log(todo_items.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo',
      theme: ThemeData(primaryColor: Colors.blue),
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Todo List'),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_back),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_upward),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_downward),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_forward),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: todo_items.length,
          itemBuilder: (BuildContext context, int index) {
            return Text(todo_items[index]['title']);
          },
        ),
        /*body: ListView(
          children: const <Widget>[
            Text('Orange'),
            Text('Apple'),
          ],
        ),*/
      ),
    );
  }
}
