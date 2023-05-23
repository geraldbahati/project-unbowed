// colours
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:unbowed_flutter/presentation/styles/text_styling.dart';

const Color lightBlue = Color.fromRGBO(27, 90, 212, 1);
const Color darkBlue = Color.fromRGBO(30, 34, 121, 1);

// light mode theme
AppBarTheme lightAppBarTheme = AppBarTheme(
  backgroundColor: Colors.white,
  titleTextStyle: TextStyle(
    fontSize: 20.sp,
    color: Colors.black,
  ),
  iconTheme: const IconThemeData(
    color: Color.fromRGBO(149, 150, 152, 0.6),
  ),
);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: Color.fromRGBO(243, 243, 243, 1),
    primary: Color.fromRGBO(100, 100, 100, 0.39),
    secondary: Color.fromRGBO(224, 224, 224, 0.88),
  ),
  appBarTheme: lightAppBarTheme,
);

// dark mode theme
AppBarTheme darkAppBarTheme = AppBarTheme(
  backgroundColor: const Color.fromRGBO(25, 26, 28, 0.11),
  titleTextStyle: TextStyle(
    fontSize: 20.sp,
    color: Colors.white,
  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    background: Color.fromRGBO(23, 24, 26, 1),
    primary: Color.fromRGBO(178, 178, 178, 0.7),
    secondary: Color.fromRGBO(41, 42, 44, 0.17),
  ),
  appBarTheme: darkAppBarTheme,
);
