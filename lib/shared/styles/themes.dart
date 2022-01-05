
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

final ThemeData lightTheme = ThemeData(
  primaryColor: Colors.black,
  unselectedWidgetColor: Colors.black,
  primarySwatch: defaultLightColor,
  scaffoldBackgroundColor:  HexColor('#f7e094'),
  bottomNavigationBarTheme:  BottomNavigationBarThemeData(
    backgroundColor: HexColor('#f7e094'),
    selectedItemColor: defaultLightColor,
    type: BottomNavigationBarType.fixed,
    elevation: 50,

  ),
  appBarTheme:  AppBarTheme(

    titleSpacing: 20,
    color: HexColor('#f7e094'),
    iconTheme: const IconThemeData(
      color: Colors.black,

    ),
    titleTextStyle: const TextStyle(

        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black
    ),
    elevation: 0,
    systemOverlayStyle:  SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: HexColor('#f7e094'),
    ),
  ),
  textTheme: const TextTheme(

    bodyText1: TextStyle(

      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
  fontFamily: 'arabic',

);

final ThemeData darkTheme = ThemeData(
  primaryColor: Colors.orange,
   unselectedWidgetColor: Colors.orange,
   primarySwatch: defaultDarkColor,
   scaffoldBackgroundColor: HexColor('121212'),
  bottomNavigationBarTheme:  BottomNavigationBarThemeData(
    backgroundColor: HexColor('121212'),
    unselectedItemColor: Colors.grey,
    selectedItemColor: defaultDarkColor,
    type: BottomNavigationBarType.fixed,
    elevation: 50,
  ),
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    color: HexColor('121212'),
    iconTheme: const IconThemeData(
      color: defaultDarkColor,
    ),
    titleTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: defaultDarkColor
    ),
    elevation: 0,
    systemOverlayStyle:  SystemUiOverlayStyle(
      statusBarColor: HexColor('121212'),
      statusBarIconBrightness:  Brightness.light,
    ),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),

  ),

    fontFamily: 'arabic',
);

