import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:orange/main.dart';

class MyTodoInfoPage extends StatefulWidget {
  const MyTodoInfoPage({super.key, required this.id});
  // 表示するtodoのid
  final int id;

  @override
  State<MyTodoInfoPage> createState() => _MyTodoInfoPage();
}

class _MyTodoInfoPage extends State<MyTodoInfoPage> {
  //表示するためのtodo(json)を格納する変数
  var todo_item;

  @override
  void initState() {
    super.initState();
    getTodo();
  }

  // todoのデータ一つを取得してtodo_itemに格納するメソッド
  Future<void> getTodo() async {
    log('getTodo');
    var response =
        await http.get(Uri.http('127.0.0.1:5000', 'api/todos/${widget.id}'));
    // utf8は文字化け対策
    var jsonRes = jsonDecode(utf8.decode(response.bodyBytes));
    log(jsonRes.toString());
    setState(() {
      todo_item = jsonRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return todo_item == null
        ? const Center(child: CircularProgressIndicator())
        : WillPopScope(
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
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('タイトル:'),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(todo_item['title']),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text('説明:'),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(todo_item['description']),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // 削除ボタン
                        Expanded(
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              '削除',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        // 変更ボタン
                        Expanded(
                          //width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text(
                              '編集',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
