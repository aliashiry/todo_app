import 'package:flutter/material.dart';

class MyTheme {
  // colors - light - dark
  static Color blackColor = Color(0xff383838);
  static Color whiteColor = Color(0xffffffff);
  static Color redColor = Color(0xffEC4B4B);
  static Color greyColor = Color(0xff9a8d8d);
  static Color greenColor = const Color(0xff61E757);
  static Color primaryColor = Color(0xff5D9CEC);
  static Color backgroundDarkColor = const Color(0xff060E1E);
  static Color backgroundColor = const Color(0xffDFECDB);
  static Color blackDarkColor = const Color(0xff141922);
  static ThemeData lightTheme = ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: whiteColor,
        ),
        titleMedium: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.w400,
          color: whiteColor,
        ),
        titleSmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: blackColor,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: primaryColor,
        unselectedItemColor: greyColor,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        shape: StadiumBorder(
          side: BorderSide(
            color: whiteColor,
            width: 3,
          ),
        ),
        // RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(70),
        //   side: BorderSide(
        //     color: whiteColor,
        //     width: 4,
        //   ),
        // ),
      ));

  static ThemeData darkMode = ThemeData(
      primaryColor: primaryColor,
      // scaffoldBackgroundColor: Colors.transparent,
      appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          elevation: 0,
          iconTheme: IconThemeData(color: MyTheme.blackColor)),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: blackColor,
        ),
        titleMedium: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.w400,
          color: whiteColor,
        ),
        titleSmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: blackColor,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: primaryColor,
        unselectedItemColor: greyColor,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: StadiumBorder(
          side: BorderSide(
            color: whiteColor,
            width: 4,
          ),
        ),
        // RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(70),
        //   side: BorderSide(
        //     color: whiteColor,
        //     width: 4,
        //   ),
        // ),
      ));
}
