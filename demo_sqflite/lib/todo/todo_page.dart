import 'package:demo_sqflite/todo/todo_header.dart';
import 'package:demo_sqflite/todo/todo_list.dart';
import 'package:flutter/material.dart';

class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          TodoHeader(),
          Expanded(
            child: TodoList(),
          ),
        ],
      ),
    );
  }
}
