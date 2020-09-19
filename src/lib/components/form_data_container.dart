import 'package:flutter/material.dart';

class FormDataContainer extends StatelessWidget {
  final String _text;
  final IconData _icon;
  final Widget _child;
  final Function _onTap;

  FormDataContainer(this._text, this._icon, this._child, this._onTap);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: _onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
              alignment: Alignment.bottomLeft,
              child: Text(_text),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
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
        ),
      );
}
