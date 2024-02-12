import 'package:flutter/material.dart';

class MyTheme {
  // colors - light - dark
  static Color blackColor = Color(0xff383838);
  static Color WhiteColor = Color(0xffffffff);
  static Color blueColor = Color(0xff5D9CEC);
  static Color greenColor = const Color(0xff61E757);
  static Color primaryLight = const Color(0xffDFECDB);
  static Color primaryDark = const Color(0xff060E1E);
  static ThemeData lightMode = ThemeData(
    primaryColor: primaryLight,
    //scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: blueColor,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      titleMedium: TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      titleSmall: TextStyle(
        fontSize: 24,
        //fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: blueColor,
        //showUnselectedLabels: true,
        backgroundColor: primaryLight),
  );
  static ThemeData darkMode = ThemeData(
    primaryColor: primaryDark,
    // scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: AppBarTheme(
        centerTitle: true,
        //backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: MyTheme.blackColor)),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: MyTheme.WhiteColor,
      ),
      titleMedium: TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.w400,
        color: MyTheme.WhiteColor,
      ),
      titleSmall: TextStyle(
        fontSize: 24,
        //fontWeight: FontWeight.bold,
        color: MyTheme.WhiteColor,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: blueColor,
    ),
  );
}
