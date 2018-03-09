import 'package:flutter/material.dart';
import '../utils/todos.dart';

class SingleTodo extends StatefulWidget {
  final Todo todo;
  final int index;
  final ValueChanged<int> onTap;
  final ValueChanged<int> onLongPress;
  SingleTodo({this.todo, this.index, this.onTap, this.onLongPress});

  @override
  _SingleTodoState createState() => new _SingleTodoState();
}

class _SingleTodoState extends State<SingleTodo>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        duration: new Duration(milliseconds: 800), vsync: this);
    
    this.setState(() {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void del() {
    this.setState(() {
      _controller.reverse().whenComplete(() {
        
        widget.onLongPress(widget.index);
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    
    return new SizeTransition(
      sizeFactor: new CurvedAnimation(
          reverseCurve: Curves.fastOutSlowIn,
            parent: _controller, curve: Curves.easeIn),
      child: new InkWell(
        onTap: () => widget.onTap(widget.index),
        onLongPress: del,
        child: new Container(
          color: _controller.status == AnimationStatus.reverse ? Colors.red[50] :Colors.transparent,
          //modified
          margin: const EdgeInsets.symmetric(vertical: 1.0),
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: new IconButton(
                  onPressed: () => widget.onTap(widget.index),
                  icon: new Icon(widget.todo.completed
                      ? Icons.check_box
                      : Icons.check_box_outline_blank),
                  color: widget.todo.completed
                      ? Colors.greenAccent
                      : Colors.blueAccent,
                ),
              ),
              new Expanded(
                child: new Text(
                  widget.todo.todo,
                  style: new TextStyle(
                    decoration: widget.todo.completed
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
