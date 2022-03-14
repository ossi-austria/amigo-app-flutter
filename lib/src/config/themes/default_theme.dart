import 'package:flutter/material.dart';

class AmigoColors {
  static const primaryColor = Color(0xff075760);
  static const primaryDarkColor = Color(0xff00292e);
  static const secondaryColor = Color(0xffffba5f);
  static const backgroundColor = Color(0xffe5e5e5);
  static const secondaryColorDisabled = Color(0xff907a61);
  static const redColor = Color(0xffff5f5f);

}

class DefaultTheme {
  static const primaryColor = Color(0xff075760);
  static const secondaryColor = Color(0xffffba5f);

  static const labelTextStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    height: 1.375,
    fontWeight: FontWeight.w700,
    color: AmigoColors.primaryDarkColor,
  );

  static const footnoteTextStyle = TextStyle(
    fontSize: 14,
    height: 1.1428,
    fontWeight: FontWeight.w400,
    color: AmigoColors.primaryDarkColor,
  );

  static final ThemeData themeData = ThemeData(
    primaryColor: primaryColor,
    primaryColorLight: primaryColor,
    primaryColorDark: primaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AmigoColors.backgroundColor,
      titleTextStyle: TextStyle(
          color: AmigoColors.primaryDarkColor, fontWeight: FontWeight.w400, fontSize: 18),
      iconTheme: IconThemeData(color: AmigoColors.primaryDarkColor),
    ),
    colorScheme: ThemeData().colorScheme.copyWith(secondary: secondaryColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 19.0, horizontal: 24.0),
        onPrimary: Colors.black,
        primary: secondaryColor,
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
    scaffoldBackgroundColor: AmigoColors.backgroundColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: primaryColor,
      unselectedItemColor: Colors.white,
      selectedItemColor: secondaryColor,
    ),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      margin: const EdgeInsets.only(bottom: 15),
    ),
    textTheme: const TextTheme(
      // figma headline x-large
      headline1: TextStyle(
        fontFamily: 'DMSerifDisplay',
        fontSize: 64,
        height: 0.9375,
      ),
      // figma headline large
      headline2: TextStyle(
        color: AmigoColors.primaryDarkColor,
        fontFamily: 'DMSerifDisplay',
        fontSize: 48,
        height: 1.0,
      ),
      // figma headline medium
      headline3: TextStyle(
        color: AmigoColors.primaryDarkColor,
        fontFamily: 'DMSerifDisplay',
        fontSize: 40,
        height: 1.1,
      ),
      // figma headline small
      headline4: TextStyle(
        fontFamily: 'DMSerifDisplay',
        fontSize: 32,
        height: 1.0625,
      ),
      subtitle1: TextStyle(
        fontSize: 24,
        height: 1.083,
        fontWeight: FontWeight.w300,
      ),
      bodyText1: TextStyle(
        fontSize: 18,
        height: 1.444444,
        fontWeight: FontWeight.w400,
      ),
      caption: TextStyle(
        fontSize: 18,
        height: 1.444444,
        fontWeight: FontWeight.w700,
      )
    ),
  );
}
