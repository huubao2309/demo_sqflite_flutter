import 'package:demo_sqflite/database/todo_db.dart';
import 'package:demo_sqflite/model/todo.dart';
import 'package:sqflite/sqflite.dart';

class TodoTable {
  static const TABLE_NAME = 'todo';
  static const CREATE_TABLE_QUERY = '''
    CREATE TABLE $TABLE_NAME (
      id INTEGER PRIMARY KEY,
      content TEXT
    );
  ''';

  static const DROP_TABLE_QUERY = '''
    DROP TABLE IF EXISTS $TABLE_NAME
  ''';

  Future<int> insertTodo(Todo todo) {
    final Database db = TodoDatabase.instance.database;
    return db.insert(
      TABLE_NAME,
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteTodo(Todo todo) async {
    final Database db = TodoDatabase.instance.database;
    await db.delete(
      TABLE_NAME,
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<List<Todo>> selectAllTodo() async {
    final Database db = TodoDatabase.instance.database;
    final List<Map<String, dynamic>> maps = await db.query('todo');

    return List.generate(maps.length, (index) {
      return Todo.fromData(
        maps[index]['id'],
        maps[index]['content'],
      );
    });
  }
}
