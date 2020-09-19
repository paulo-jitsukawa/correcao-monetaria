import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final IconData _icon;
  final String _text;
  final PageController _controller;
  final int _page;

  MenuItem(this._icon, this._text, this._controller, this._page);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          _controller.jumpToPage(_page);
        },
        child: Container(
          height: 60,
          child: Row(
            children: [
              Icon(
                _icon,
                size: 30,
                color: _controller.page.round() == _page
                    ? Theme.of(context).primaryColor
                    : Colors.grey[700],
              ),
              SizedBox(width: 30),
              Text(
                _text,
                style: TextStyle(
                  fontSize: 20,
                  color: _controller.page.round() == _page
                      ? Theme.of(context).primaryColor
                      : Colors.grey[700],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
