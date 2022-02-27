import 'package:flutter/material.dart';

final appTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.amber,
    foregroundColor: Colors.white,
  ),
  primarySwatch: Colors.amber,
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontFamily: 'Corben',
      fontWeight: FontWeight.w400,
      fontSize: 18,
      color: Colors.blueGrey,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: Colors.white,
      backgroundColor: Colors.amber,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    foregroundColor: Colors.white,
  ),
);
