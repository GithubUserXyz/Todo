import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
/**
 * import 'package:orange/main.dart';
 * の記述がないと実行時にmain.dartでMyTodoAddPage
 * を呼び出している箇所でエラーが起きた。
 * lib/main.dart:51:47: Error: The method 'MyTodoAddPage' isn't defined for the
class '_MyListPageState'.
 - '_MyListPageState' is from 'package:orange/main.dart' ('lib/main.dart').
Try correcting the name to the name of an existing method, or defining a method
named 'MyTodoAddPage'.
      MaterialPageRoute(builder: (context) => MyTodoAddPage()),
                                              ^^^^^^^^^^^^^

 * そのため、記述を追加した。
 */
import 'package:orange/main.dart';

class MyTodoAddPage extends StatefulWidget {
  const MyTodoAddPage({Key? key}) : super(key: key);

  @override
  State<MyTodoAddPage> createState() => _MyTodoAddPageState();
}

class _MyTodoAddPageState extends State<MyTodoAddPage> {
  final titleTextFieldController = TextEditingController();
  final descriptionTextFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  // todoをpostするメソッド
  Future<void> postTodo() async {
    log('postTodo()');
    Map<String, String> headers = {'content-type': 'application/json'};
    var body = jsonEncode({
      'title': titleTextFieldController.text,
      'description': descriptionTextFieldController.text
    });
    final response = await http.post(
      Uri.http('127.0.0.1:5000', 'api/todos'),
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
        // 左上のbackの戻り値の設定
        // 戻り値はpop()の中に設定される。
        Navigator.of(context).pop('');
        return Future.value(false);
      },
      child: Scaffold(
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
              TextField(
                controller: titleTextFieldController,
                onChanged: (text) {
                  //title = text;
                },
              ),
              // 余白
              const SizedBox(height: 8),
              // description入力用のテキストフィールド
              TextField(
                controller: descriptionTextFieldController,
                onChanged: (text) {
                  //description = text;
                },
              ),
              // 余白
              const SizedBox(height: 8),
              // todo追加用のボタン
              // 'Todo 追加'と表示されて、押下するとtodo postを実行する
              Container(
                // 横に広げる
                width: double.infinity,
                // ボタンの実装(todo postの実行)
                child: ElevatedButton(
                  onPressed: () {
                    log(titleTextFieldController.text);
                    log(descriptionTextFieldController.text);
                    // postの実行
                    postTodo();
                    // ここでpopして前のリストビューの画面に戻すと、
                    // リストビューで行っているgetメソッドのほうが
                    // ここで実行しているpostメソッドよりも
                    // はやく実行されてしまっていて、データがリストに格納
                    // されないということが発生したため、
                    // ここでpopでもどすようにしていない。
                    // 前の画面にもどるには左上のbackボタンをおすようにしている。

                    // 画面にポップアップを表示して保存内容を表示
                    // 変数をのちにクリアするのでその前にローカル変数に保存
                    var title = titleTextFieldController.text;
                    var desc = descriptionTextFieldController.text;
                    // alertdailogの表示
                    showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: const Text('追加内容'),
                          content: Text('title: ${title} description: ${desc}'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );

                    // postTodoが実行されて問題なければ、
                    // テキストフィールドの値はクリアしておく。
                    titleTextFieldController.clear();
                    descriptionTextFieldController.clear();
                  },
                  child: const Text('Todo 追加',
                      style: TextStyle(color: Colors.white)),
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
                    //Navigator.of(context).pop();
                    Navigator.pop(context, '');
                  },
                  child: const Text('キャンセル'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
