import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

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

  // todo1件を削除するメソッド
  Future<void> deleteTodo() async {
    log('deleteTodo');
    final response =
        await http.delete(Uri.http('127.0.0.1:5000', 'api/todos/${widget.id}'));
    if (!mounted) return;
    if (response.statusCode == 200) {
      // utf8は文字化け対策
      //var jsonRes = jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to delete Todo');
    }
  }

  // 削除したときに表示するページへ遷移
  Future<void> _navigateAndDisplayTodoDeletedPage(BuildContext context) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const MyTodoDeletePage()));
    if (!mounted) return;
  }

  // 編集ページへ遷移
  Future<void> _navigateAndDisplayTodoUpdatePage(BuildContext context) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyTodoUpdatePage(id: widget.id),
        ));
    if (!mounted) return;
    setState(() {
      getTodo();
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
                            onPressed: () {
                              deleteTodo();
                              //Navigator.pop(context, 'deleted');
                              //Navigator.of(context).pop('deleted');
                              _navigateAndDisplayTodoDeletedPage(context);
                            },
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
                            onPressed: () {
                              _navigateAndDisplayTodoUpdatePage(context);
                            },
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

// 削除ボタンを押して削除が実行されたあと、この画面に遷移
class MyTodoDeletePage extends StatefulWidget {
  const MyTodoDeletePage({Key? key}) : super(key: key);

  @override
  State<MyTodoDeletePage> createState() => _MyTodoDeletePage();
}

class _MyTodoDeletePage extends State<MyTodoDeletePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}

class MyTodoUpdatePage extends StatefulWidget {
  const MyTodoUpdatePage({super.key, required this.id});
  final int id;

  @override
  State<MyTodoUpdatePage> createState() => _MyTodoUpdatePage();
}

class _MyTodoUpdatePage extends State<MyTodoUpdatePage> {
  // 変更するためのtodo(json)を格納する変数
  var todo_item;

  final titleTextFieldController = TextEditingController();
  final descriptionTextFieldController = TextEditingController();

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
      titleTextFieldController.text = todo_item['title'];
      descriptionTextFieldController.text = todo_item['description'];
    });
  }

  // todoデータをupdateするメソッド
  Future<void> updateTodo() async {
    log('updateTodo');
    Map<String, String> headers = {'content-type': 'application/json'};
    var body = jsonEncode({
      'title': titleTextFieldController.text,
      'description': descriptionTextFieldController.text
    });
    final response = await http.put(
      Uri.http('127.0.0.1:5000', 'api/todos/${widget.id}'),
      headers: headers,
      body: body,
    );
    if (!mounted) return;
    var jsonRes = jsonDecode(response.body);
    log(jsonRes.toString());
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to create Todo');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop('');
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Todo 変更')),
        body: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              TextField(
                controller: titleTextFieldController,
                onChanged: (text) {},
              ),
              const SizedBox(height: 8),
              TextField(
                controller: descriptionTextFieldController,
                onChanged: (text) {},
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    updateTodo();
                  },
                  child: const Text('Todo 変更',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context, '');
                  },
                  child: const Text('キャンセル'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
