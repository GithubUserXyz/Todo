import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:grape/edit_page.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';
import 'main_state.dart';
import 'model/entity/todo.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
      path: HomePage.routeName,
      builder: (context, state) {
        return const HomePage();
      },
      routes: [
        GoRoute(
          name: 'EditTodo',
          path: '${EditPage.routeName}/:id',
          builder: (context, state) {
            final id = state.pathParameters['id'];
            if (id == null) {
              return EditPage();
            } else {
              Todo? todo =
                  Provider.of<MainState>(context).todoItems[int.parse(id)];
              return EditPage(todo: todo);
            }
          },
        ),
        GoRoute(
          name: 'AddTodo',
          path: EditPage.routeName,
          builder: (context, state) {
            return EditPage();
          },
        ),
      ],
    ),
  ],
);

void main(List<String> args) {
  GetIt.instance.registerLazySingleton(() => MainState());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<MainState>.value(value: GetIt.I<MainState>())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}
