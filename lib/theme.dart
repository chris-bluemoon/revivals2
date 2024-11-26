import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static Color primaryColor = const Color.fromARGB(255, 255, 255, 255);
  static Color primaryAccent = const Color.fromRGBO(120, 14, 14, 1);
  static Color secondaryColor = const Color.fromARGB(255, 255, 255, 255);
  static Color secondaryAccent = const Color.fromARGB(255, 255, 255, 255);
  static Color titleColor = const Color.fromARGB(255, 0, 0, 0);
  static Color textColor = const Color.fromARGB(255, 0, 0, 0);
  static Color successColor = const Color.fromRGBO(9, 149, 110, 1);
  static Color highlightColor = const Color.fromRGBO(212, 172, 13, 1);
}

ThemeData primaryTheme = ThemeData(
  splashColor: Colors.white,
  // seed color theme
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primaryColor,
  ),

  // scaffold color
  scaffoldBackgroundColor: AppColors.secondaryAccent,

  // app bar theme colors
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.secondaryColor,
    foregroundColor: AppColors.textColor,
    surfaceTintColor: Colors.transparent,
    centerTitle: true,
  ),

  // text theme
  textTheme: TextTheme(
    bodyMedium: TextStyle(
      color: AppColors.textColor,
      fontSize: 12,
      fontWeight: FontWeight.normal, 
      letterSpacing: 1,
    ),
    headlineMedium: TextStyle(
      color: AppColors.titleColor, 
      fontSize: 14,
      fontWeight: FontWeight.bold, 
      letterSpacing: 1,
    ),
    titleMedium: TextStyle(
      color: AppColors.titleColor, 
      fontSize: 16, 
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
    ),
    titleLarge: TextStyle(
      color: AppColors.titleColor, 
      fontSize: 36, 
      fontWeight: FontWeight.bold,
      letterSpacing: 2,
    ),
    
  ),
  buttonBarTheme: const ButtonBarThemeData(
    buttonHeight: 100,
      buttonTextTheme: ButtonTextTheme.primary,
    ), 
        tabBarTheme: TabBarTheme(
          labelColor: Colors.black,
          indicatorColor: Colors.black,
          dividerColor: Colors.grey,
          unselectedLabelColor: Colors.grey,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
        )

);