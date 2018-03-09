import 'package:flutter/material.dart';
import '../utils/todos.dart';
import './single_todo.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final ValueChanged<int> onTap;
  final ValueChanged<int> onLongPress;
  TodoList({this.todos, this.onTap, this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return new Flexible(
      child: new ListView.builder(
        itemCount: todos.length,

        
        itemBuilder: (context, index) {
          final todo = todos[index];
          return new SingleTodo(
            todo: todo,
            onTap: onTap,
            onLongPress: onLongPress,
            index: index,
          );
        },
      ),
    );
  }
}
