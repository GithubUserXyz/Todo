import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'MyTodoAddPage.dart' show MyTodoAddPage;
import 'package:orange/main.dart';

class MyListPage extends StatefulWidget {
  const MyListPage({Key? key}) : super(key: key);

  @override
  State<MyListPage> createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  List todo_items = [];

  // todoリストを取得してtodo_itemsに格納するメソッド
  Future<void> getTodo() async {
    log('getTodo()');
    var response = await http.get(Uri.http('127.0.0.1:5000', 'api/todos'));
    // utf8は文字化け対策
    var jsonRes = jsonDecode(utf8.decode(response.bodyBytes));
    log(jsonRes.toString());
    setState(() {
      todo_items = jsonRes;
    });
  }

  // todo追加するページを表示する
  Future<void> _navigateAndDisplayTodoAddPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyTodoAddPage()),
    );

    if (!mounted) return;

    log(result);
    // 再描画
    getTodo();
  }

  // 初期化処理
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
            return GestureDetector(
              onTap: () {
                log(todo_items[index]['id'].toString());
              },
              child: Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(todo_items[index]['title']),
                      subtitle: Text(todo_items[index]['description']),
                    )
                  ],
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _navigateAndDisplayTodoAddPage(context);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
