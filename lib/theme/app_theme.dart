import 'package:flutter/material.dart';

class AppTheme {
  static final appTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xffF3F4F6),
    fontFamily: 'Inter',
    useMaterial3: false,
    appBarTheme: const AppBarTheme(
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      elevation: 0,
      color: Colors.transparent,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: InputBorder.none,
      hintStyle: TextStyle(
        color: Color(0xff99A1AF),
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
