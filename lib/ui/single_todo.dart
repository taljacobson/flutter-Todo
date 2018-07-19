import 'package:flutter/material.dart';
import '../utils/todos.dart';

class SingleTodo extends StatefulWidget {
  final Todo todo;
  final int index;
  final Function(Todo todo) onTap;
  final Function(Todo todo) onLongPress;
  SingleTodo({Key key, this.todo, this.index, this.onTap, this.onLongPress})
      : super(key: key);

  @override
  _SingleTodoState createState() => new _SingleTodoState();
}

class _SingleTodoState extends State<SingleTodo>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = new AnimationController(
        duration: new Duration(milliseconds: 800), vsync: this)
      ..addListener(animationListener);

    this.setState(() {
      _controller.forward();
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller?.removeListener(animationListener);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void deactivate() async {
    super.deactivate();
  }

  del() async {
    await _controller.reverse();
    widget.onLongPress(widget.todo);
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(
          reverseCurve: Curves.fastOutSlowIn,
          parent: _controller,
          curve: Curves.easeIn),
      child: InkWell(
        onTap: () => widget.onTap(widget.todo),
        onLongPress: del,
        child: Container(
          color: _controller.status == AnimationStatus.reverse
              ? Colors.red[50]
              : Colors.transparent,
          //modified
          margin: const EdgeInsets.symmetric(vertical: 1.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: IconButton(
                  onPressed: () => widget.onTap(widget.todo),
                  icon: Icon(widget.todo.completed
                      ? Icons.check_box
                      : Icons.check_box_outline_blank),
                  color: widget.todo.completed
                      ? Colors.greenAccent
                      : Colors.blueAccent,
                ),
              ),
              new Expanded(
                child: Text(
                  widget.todo.todo,
                  style: TextStyle(
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

  void animationListener() {
    setState(() {});
  }
}
