import 'dart:async';
import 'dart:math';

import 'package:demo_sqflite/base/base_bloc.dart';
import 'package:demo_sqflite/base/base_event.dart';
import 'package:demo_sqflite/database/todo_table.dart';
import 'package:demo_sqflite/event/add_todo_event.dart';
import 'package:demo_sqflite/event/delete_todo_event.dart';
import 'package:demo_sqflite/model/todo.dart';

class TodoBloc extends BaseBloc {
  TodoTable _todoTable = TodoTable();

  StreamController<List<Todo>> _todoListStreamController =
      StreamController<List<Todo>>();
  Stream<List<Todo>> get todoListStream => _todoListStreamController.stream;

  var _random = Random();
  List<Todo> _todoListData = List<Todo>();

  _addTodo(Todo todo) async {
    // insert to DB
    await _todoTable.insertTodo(todo);

    // add todo to List
    _todoListData.add(todo);

    // push event
    _todoListStreamController.sink.add(_todoListData);
  }

  _deleteTodo(Todo todo) async {
    // delete to DB
    await _todoTable.deleteTodo(todo);

    // delete todo to List
    _todoListData.remove(todo);

    // push event
    _todoListStreamController.sink.add(_todoListData);
  }

  initData() async {
    _todoListData = await _todoTable.selectAllTodo();
    if (_todoListData == null) {
      return;
    }

    _todoListStreamController.sink.add(_todoListData);
  }

  @override
  void dispatchEvent(BaseEvent event) {
    if (event is AddTodoEvent) {
      Todo todo = Todo.fromData(
        _random.nextInt(10000),
        event.content,
      );
      _addTodo(todo);
    } else if (event is DeleteTodoEvent) {
      _deleteTodo(event.todo);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _todoListStreamController.close();
  }
}
