import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grape/main_state.dart';
import 'package:provider/provider.dart';

import 'edit_page.dart';
import 'model/entity/todo.dart';

class HomePage extends StatelessWidget {
  static String routeName = '/';
  static String screenName = 'Home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(screenName)),
      body: buildTodoList(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/${EditPage.routeName}');
        },
        child: const Icon(Icons.add),
      ),
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
          Todo currentTodo = mainState.todoItems[index];
          return GestureDetector(
            onTap: () {
              context.push('/${EditPage.routeName}/$index');
            },
            onDoubleTap: () async {
              mainState.deleteTodo(mainState.todoItems[index].id);
            },
            child: ListTile(
              title: Text(currentTodo.title),
              subtitle: Text(currentTodo.description),
            ),
          );
        },
      ),
    );
  }
}
