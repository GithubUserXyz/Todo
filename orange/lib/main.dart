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
            return Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(todo_items[index]['title']),
                    subtitle: Text(todo_items[index]['description']),
                  )
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return MyTodoAddPage();
              }),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class MyTodoAddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo 追加'),
      ),
      body: Container(
        // まわりに余白を追加
        padding: EdgeInsets.all(8),
        // todo post用のテキストフィールド
        child: Column(
          children: <Widget>[
            // title入力用のテキストフィールド
            TextField(),
            // 余白
            const SizedBox(height: 8),
            // description入力用のテキストフィールド
            TextField(),
            // 余白
            const SizedBox(height: 8),
            // todo追加用のボタン
            // 'Todo 追加'と表示されて、押下するとtodo postを実行する
            Container(
              // 横に広げる
              width: double.infinity,
              // ボタンの実装(todo postの実行)
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Todo 追加', style: TextStyle(color: Colors.white)),
              ),
            ),
            // 余白
            const SizedBox(height: 8),
            // 前の画面に戻るボタン 'キャンセル'と表示
            Container(
              // 横に広げる
              width: double.infinity,
              // ボタンの実装(キャンセル処理、前の画面に戻る)
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('キャンセル'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
