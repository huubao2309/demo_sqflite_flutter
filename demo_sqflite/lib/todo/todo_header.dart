import 'package:demo_sqflite/bloc/todo_bloc.dart';
import 'package:demo_sqflite/event/add_todo_event.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var txtTodoController = TextEditingController();
    var bloc = Provider.of<TodoBloc>(context);
    return Row(
      children: <Widget>[
        Expanded(
          child: TextFormField(
            controller: txtTodoController,
            decoration: InputDecoration(
              labelText: 'Add Todo',
              hintText: 'Input Text...',
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        RaisedButton.icon(
          color: Colors.green,
          onPressed: () {
            bloc.event.add(AddTodoEvent(txtTodoController.text));
            txtTodoController.clear();
          },
          icon: Icon(Icons.add),
          label: Text('Add'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ],
    );
  }
}
