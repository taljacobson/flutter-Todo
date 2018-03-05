import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';

class FormInput extends StatefulWidget {
  final ValueChanged<String> onChange;
  FormInput(this.onChange);

  @override
  State<StatefulWidget> createState() => new FormInputState();
}

class FormInputState extends State<FormInput> {
  final TextEditingController _textController = new TextEditingController();
  bool _isComposing = false;
  final formKey = new GlobalKey<FormState>();

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _isComposing = false;
      widget.onChange(text);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _textController,
                onChanged: (String text) {
                  setState(() {
                    _isComposing = text.length > 0;
                  }); //new
                },
                onSubmitted: _handleSubmitted,
                decoration:
                    new InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: Theme.of(context).platform == TargetPlatform.iOS
                  ? //modified
                  new CupertinoButton(
                      //new
                      child: new Text("Send"),
                      onPressed: _isComposing
                          ? () => _handleSubmitted(_textController.text)
                          : null,
                    )
                  : new IconButton(
                      icon: new Icon(Icons.send),
                      onPressed: _isComposing
                          ? () => _handleSubmitted(_textController.text)
                          : null,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
