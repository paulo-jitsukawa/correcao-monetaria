import 'package:correcao_monetaria/views/frame.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MaterialApp(
    theme: ThemeData(
      backgroundColor: Colors.grey[50],
      appBarTheme:
          const AppBarTheme(color: Colors.blueAccent, centerTitle: true),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.blueAccent)),
        buttonColor: Colors.blueAccent,
        disabledColor: Colors.blueGrey,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        contentPadding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
        prefixStyle: const TextStyle(
            color: Colors.blueGrey, fontWeight: FontWeight.bold),
        enabledBorder: const UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        border: const UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
        ),
      ),
    ),
    debugShowCheckedModeBanner: false,
    home: Frame(),
  ));
}
