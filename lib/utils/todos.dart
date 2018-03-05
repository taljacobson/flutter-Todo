
class Todo {
  String _task;
  bool _complated = false;

  Todo(this._task);

  String get todo {
    return _task;
  }

  bool get completed {
    return _complated;
  }

  void toggle() {
    _complated = !_complated;
  }
}

