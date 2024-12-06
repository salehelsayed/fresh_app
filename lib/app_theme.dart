import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      textTheme: const TextTheme(
        bodyText1: TextStyle(color: Colors.black87),
        bodyText2: TextStyle(color: Colors.black54),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.blue,
      textTheme: const TextTheme(
        bodyText1: TextStyle(color: Colors.white70),
        bodyText2: TextStyle(color: Colors.white60),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
