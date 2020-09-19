import 'package:flutter/material.dart';

import 'menu_item.dart';

class Menu extends StatelessWidget {
  final PageController _pageController;

  Menu(this._pageController);

  @override
  Widget build(BuildContext context) {
    Widget _buildBack() => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[100], Colors.blue[50]],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        );

    return Drawer(
      child: Stack(
        children: [
          _buildBack(),
          ListView(
            padding: EdgeInsets.only(left: 30, top: 20),
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.fromLTRB(0, 20, 20, 10),
                height: 180,
                child: Column(
                  children: [
                    Image.asset(
                      'icon.png',
                      height: 80,
                    ),
                    const Text(
                      'Correção\nMonetária',
                      style: TextStyle(
                        fontSize: 30,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              MenuItem(Icons.calculate, 'Calculadora', _pageController, 0),
              MenuItem(Icons.info, 'Informações', _pageController, 1),
            ],
          ),
        ],
      ),
    );
  }
}
