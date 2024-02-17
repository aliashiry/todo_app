import 'package:flutter/material.dart';

class MyTheme {
  // colors - light - dark
  static Color blackColor = const Color(0xff070707);
  static Color whiteColor = const Color(0xffffffff);
  static Color redColor = const Color(0xffEC4B4B);
  static Color greyColor = const Color(0xff9a8d8d);
  static Color greenColor = const Color(0xff61E757);
  static Color primaryColor = const Color(0xff5D9CEC);
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
      ),
      bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: whiteColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: whiteColor),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          )));

  static ThemeData darkMode = ThemeData(
    primaryColor: backgroundDarkColor,
    // scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        elevation: 0,
        iconTheme: IconThemeData(color: MyTheme.whiteColor)),
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
        fontWeight: FontWeight.w400,
        color: whiteColor,
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
    ),
    bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: backgroundDarkColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: backgroundDarkColor),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        )),
  );
}
