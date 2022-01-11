import 'package:flutter/material.dart';

class DefaultTheme {
  static const _primaryColor = Color(0xff075760);
  static const _secondaryColor = Color(0xffffba5f);

  static final ThemeData themeData = ThemeData(
    primaryColor: _primaryColor,
    primaryColorLight: _primaryColor,
    primaryColorDark: _primaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xffe5e5e5),
      titleTextStyle: TextStyle(
          color: Color(0xff00292e), fontWeight: FontWeight.w400, fontSize: 18),
      iconTheme: IconThemeData(color: Color(0xff00292e)),
    ),
    colorScheme: ThemeData().colorScheme.copyWith(secondary: _secondaryColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        onPrimary: Colors.black,
        primary: _secondaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.zero,
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
      ),
    ),
    fontFamily: 'Karla',
    scaffoldBackgroundColor: const Color(0xffe5e5e5),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: _primaryColor,
      unselectedItemColor: Colors.white,
      selectedItemColor: _secondaryColor,
    ),
  );
}
