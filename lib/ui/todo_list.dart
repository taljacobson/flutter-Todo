import 'package:flutter/material.dart';
import '../utils/todos.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final ValueChanged<int> _onTap;
  final ValueChanged<int> _onLongPress;
  TodoList(this.todos, this._onTap, this._onLongPress);

  @override
  Widget build(BuildContext context) {
    return new Flexible(
      child: new ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final message = todos[index];
          return _todoItem(message, index);
        },
      ),
    );
  }

  Widget _todoItem(Todo message, int index) {
    return new InkWell(
      onTap: () => _onTap(index),
      onLongPress: () => _onLongPress(index),
      child: new Container(
        //modified
        margin: const EdgeInsets.symmetric(vertical: 1.0),
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: new IconButton(
                onPressed: () => _onTap(index),
                icon: new Icon(message.completed
                    ? Icons.check_box
                    : Icons.check_box_outline_blank),
                color:
                    message.completed ? Colors.greenAccent : Colors.blueAccent,
              ),
            ),
            new Expanded(
              child: new Text(
                message.todo,
                style: new TextStyle(
                  decoration: message.completed
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
