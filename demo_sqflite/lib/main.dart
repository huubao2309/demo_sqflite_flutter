import 'package:demo_sqflite/bloc/todo_bloc.dart';
import 'package:demo_sqflite/todo/todo_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'database/todo_db.dart';

void main() async {
  // Init DB
  WidgetsFlutterBinding.ensureInitialized();
  await TodoDatabase.instance.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo SqfLite',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Todo App'),
        ),
        body: Provider<TodoBloc>.value(
          value: TodoBloc(),
          child: TodoPage(),
        ),
      ),
    );
  }
}
