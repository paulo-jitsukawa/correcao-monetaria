import 'package:flutter/material.dart';

class FormContainer extends StatelessWidget {
  final String _text;
  final Widget _child;

  FormContainer(this._text, this._child);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
            alignment: Alignment.bottomLeft,
            child: Text(_text),
          ),
          Container(
            child: _child,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey[300]),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
          )
        ],
      );
}
