import 'package:demo_sqflite/bloc/todo_bloc.dart';
import 'package:demo_sqflite/event/delete_todo_event.dart';
import 'package:demo_sqflite/model/todo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Get value of Bloc
    var bloc = Provider.of<TodoBloc>(context);
    bloc.initData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoBloc>(
      builder: (context, bloc, child) => StreamBuilder<List<Todo>>(
          stream: bloc.todoListStream,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
                return ListView.builder(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        snapshot.data[index].content,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          // Delete Todo record
                          bloc.event.add(DeleteTodoEvent(snapshot.data[index]));
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.red[400],
                        ),
                      ),
                    );
                  },
                );
              case ConnectionState.waiting:
                return Center(
                  child: Container(
                    width: 70,
                    height: 70,
                    child: Text(
                      'Empty',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                );
              case ConnectionState.none:
              default:
                return Center(
                  child: Container(
                    width: 70,
                    height: 70,
                    child: CircularProgressIndicator(),
                  ),
                );
            }
          }),
    );
  }
}
