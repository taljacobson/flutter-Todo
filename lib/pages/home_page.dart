import 'package:flutter/material.dart';
import '../utils/todos.dart';
import '../ui/FormInput.dart';
import '../ui/todo_list.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Todo> todos;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var newtodos = [
      new Todo('make bread'),
      new Todo('drink milk'),
    ];

    setState(() {
      todos = newtodos;
    });
  }

  _handleInput(String str) {
    if (str.length < 4) return;
    setState(() {
      todos.add(new Todo(str));
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Todo'),
        actions: <Widget>[
          new MaterialButton(
            
            textColor: Colors.white,
            onPressed: removeCompleted,

              padding: new EdgeInsets.symmetric(horizontal: 10.0),
              child: new Text(
                todos.where((test) => test.completed).length.toString(),
                style:
                    new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),

          ),
        ],
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new TodoList(
              todos: todos,
              onTap: toggleTodo,
              onLongPress: delTodo
            ),
            new Divider(height: 11.0),
            new Center(
              child: new Padding(
                padding: new EdgeInsets.symmetric(horizontal: 10.0),
                child: new FormInput((str) => _handleInput(str)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void toggleTodo(int index) {
    setState(() {
      todos[index].toggle();
    });
  }

  void delTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  void removeCompleted() {
    List<Todo> newTodo = todos.where((todo) => !todo.completed).toList();

    setState(() {
      todos = newTodo;
    });
  }
}
