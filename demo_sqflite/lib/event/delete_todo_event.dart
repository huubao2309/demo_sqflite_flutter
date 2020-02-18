import 'package:demo_sqflite/base/base_event.dart';
import 'package:demo_sqflite/model/todo.dart';

class DeleteTodoEvent extends BaseEvent {
  Todo todo;
  DeleteTodoEvent(this.todo);
}
