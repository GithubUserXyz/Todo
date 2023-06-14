import 'package:flutter/material.dart';
import 'package:grape/main_state.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static String routeName = '/';
  static String screenName = 'Home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(screenName)),
      body: buildTodoList(context),
    );
  }

  Widget buildTodoList(BuildContext context) {
    var mainState = Provider.of<MainState>(context);
    if (mainState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (mainState.todoItems.isEmpty) {
      return const Center(child: Text('Todoが作成されていません。'));
    }
    return RefreshIndicator(
      onRefresh: () async {
        await mainState.readTodos();
      },
      child: ListView.builder(
        itemCount: mainState.todoItems.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(children: <Widget>[
              ListTile(
                title: Text(mainState.todoItems[index].title),
                subtitle: Text(mainState.todoItems[index].description),
              )
            ]),
          );
        },
      ),
    );
  }
}
