import 'package:flutter/material.dart';
import 'package:jii_comic_mobile/utils/color_constants.dart';

ThemeData defaultTheme = ThemeData(
  // Default font family
  fontFamily: "Roboto",
  // Reset default color
  primarySwatch: Colors.orange,
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange),
  appBarTheme: AppBarTheme(
    foregroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.white),
  ),

  scaffoldBackgroundColor: Color(0xFFEEEEEE),
  textTheme: TextTheme(
    headline1: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.w500,
      color: Colors.black.withOpacity(0.87),
    ),
    headline2: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w500,
      color: Colors.black.withOpacity(0.87),
    ),
    headline3: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: Colors.black.withOpacity(0.87),
    ),
    headline4: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: Colors.black.withOpacity(0.87),
    ),
    caption: TextStyle(
      fontSize: 12,
      color: Colors.black.withOpacity(0.87),
    ),
  ),
);
