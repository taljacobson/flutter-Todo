import 'package:flutter/material.dart';

import '../ui/FormInput.dart';
import '../ui/todo_list.dart';
import '../utils/todos.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo'),
        actions: <Widget>[
          MaterialButton(
            textColor: Colors.white,
            onPressed: removeCompleted,
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              todos.where((test) => test.completed).length.toString(),
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            TodoList(
              todos: todos,
              onTap: toggleTodo,
              onLongPress: delTodo,
            ),
            Divider(height: 11.0),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: FormInput(
                  onChange: (str) => _handleInput(str),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void delTodo(Todo todo) {
    setState(() {
      todos.removeWhere((test) => test.todo == todo.todo);
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    var newtodos = [
      new Todo('make bread'),
      new Todo('drink milk'),
    ];

    setState(() {
      todos = newtodos;
    });
    super.initState();
  }

  void removeCompleted() {
    setState(() {
      todos.removeWhere((todo) => todo.completed);
    });
  }

  void toggleTodo(Todo todo) {
    setState(() {
      todos.singleWhere((t) => t == todo).toggle();
    });
  }

  _handleInput(String str) {
    if (str.length < 4) return;
    setState(() {
      todos.add(new Todo(str));
    });
  }
}
