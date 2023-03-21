import 'package:flutter/material.dart';
import 'colors.dart';

ThemeData get lightThemeData => ThemeData.light().copyWith(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: lightBackground,
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            shape: const RoundedRectangleBorder(),
            foregroundColor: ThemeData.light().textTheme.labelLarge!.color)),
    colorScheme: const ColorScheme.light().copyWith(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: Colors.white));

ThemeData get darkThemeData => ThemeData.light().copyWith(
    primaryColor: primaryColor,
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            shape: const RoundedRectangleBorder(),
            foregroundColor: ThemeData.dark().textTheme.labelLarge!.color)),
    colorScheme: const ColorScheme.light().copyWith(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: Colors.grey.shade800));
