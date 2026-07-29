import 'package:azkar/core/constant/api_color.dart';
import 'package:flutter/material.dart';

// لو عندك ألوان مخصصة (ApiColor)، استبدل القيم دي بيها
final _primaryColor = ApiColor.primary ;// أخضر إسلامي هادئ، غيّره لأي لون تحبه

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme.light(
    primary: _primaryColor,
    surface: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black87),
    titleTextStyle: TextStyle(
      color: Colors.black87,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.black87, fontSize: 16),
  ),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF121212),
  colorScheme: ColorScheme.dark(
    primary: _primaryColor,
    surface: const Color(0xFF1E1E1E),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF121212),
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white70),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.white70, fontSize: 16),
  ),
);