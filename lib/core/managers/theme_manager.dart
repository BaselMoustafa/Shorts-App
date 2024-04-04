
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color_manager.dart';

abstract class ThemeManager{
  static ThemeData lightTheme=ThemeData(
    scaffoldBackgroundColor: ColorManager.black,
    textTheme: _getTextTheme(),
    appBarTheme: _getAppBarTheme(),
    iconTheme:const IconThemeData(color: ColorManager.white)
  );
  

  static AppBarTheme _getAppBarTheme() =>const AppBarTheme(
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: ColorManager.white,
      fontSize: 21,
      fontWeight: FontWeight.bold,
    ),
    backgroundColor: ColorManager.black,
    foregroundColor: ColorManager.white,
    systemOverlayStyle:SystemUiOverlayStyle(
      statusBarColor: ColorManager.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  static TextTheme _getTextTheme() =>const TextTheme(

    headlineLarge: TextStyle(
      color: ColorManager.white,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: TextStyle(
      color: ColorManager.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    headlineSmall: TextStyle(
      color: ColorManager.white,
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),



    labelLarge: TextStyle(
      color: ColorManager.grey,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    labelMedium: TextStyle(
      color: ColorManager.black,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    labelSmall: TextStyle(
      color: ColorManager.black,
      fontSize: 16,
    ),
    ////////


    // displayLarge: TextStyle(
    //   color: ColorManager.white,
    //   fontSize: 16,
    //   fontWeight: FontWeight.w500,
    // ),
    // displayMedium: TextStyle(
    //   color: ColorManager.white,
    //   fontSize: 14,
    //   fontWeight: FontWeight.w500,
    // ),
    // displaySmall: TextStyle(
    //   color: ColorManager.white,
    //   fontSize: 14,
    //   fontWeight: FontWeight.w500,
    // ),
    
    

    // bodyLarge: TextStyle(
    //   color: ColorManager.white,
    //   fontSize: 12,
    //   fontWeight: FontWeight.w500,
    // ),
    // bodyMedium: TextStyle(
    //   color: ColorManager.white,
    //   fontSize: 21,
    //   fontWeight: FontWeight.bold,
    // ),
    // bodySmall: TextStyle(
    //   color: ColorManager.,
    //   fontSize: ,
    //   fontWeight: FontWeight.,
    // ),



    // titleLarge: TextStyle(
    //   color: ColorManager.,
    //   fontSize: ,
    //   fontWeight: FontWeight.,
    // ),
    // titleMedium: TextStyle(
    //   color: ColorManager.,
    //   fontSize: ,
    //   fontWeight: FontWeight.,
    // ),
    // titleSmall: TextStyle(
    //   color: ColorManager.,
    //   fontSize: ,
    //   fontWeight: FontWeight.,
    // ),
  );
}