import 'package:flutter/material.dart';
import '../utils/todos.dart';
import './single_todo.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final Function(Todo todo) onTap;
  final Function(Todo todo) onLongPress;
  TodoList({this.todos, this.onTap, this.onLongPress});

  @override
  Widget build(BuildContext context) {
    final List<Widget> _todos = todos
        .map((Todo todo) => SingleTodo(
              key: Key(todo.todo),
              todo: todo,
              onTap: onTap,
              onLongPress: onLongPress,
            ))
        .toList();

    return Flexible(
      key: Key('list'),
      child: ListView(
        children: _todos,
      ),
    );
  }
}
