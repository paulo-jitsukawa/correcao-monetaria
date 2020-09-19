import 'package:flutter/material.dart';

class FormIconContainer extends StatelessWidget {
  final String _text;
  final IconData _icon;
  final Widget _child;

  FormIconContainer(this._text, this._icon, this._child);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
            alignment: Alignment.bottomLeft,
            child: Text(_text),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _child,
                Icon(
                  _icon,
                  color: Colors.blueGrey[300],
                ),
              ],
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueGrey[300]),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          )
        ],
      );
}
