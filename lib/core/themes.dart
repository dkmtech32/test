import 'package:flutter/material.dart';

final lightTheme = ThemeData(
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        
        actionsIconTheme: IconThemeData(color: Colors.black)),
    primarySwatch: Colors.red,
    primaryColor: Colors.white,
    tabBarTheme: const TabBarTheme(
      labelStyle: TextStyle(fontSize: 18),

       labelColor: Colors.red,
                        unselectedLabelColor: Colors.black,
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: Colors.black,
    ),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'SpaceGrotesk',
    
    textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.black)));

final darkTheme = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
        backgroundColor: Colors.black,
        actionsIconTheme: IconThemeData(color: Colors.white)),
    primarySwatch: Colors.red,
    primaryColor: Colors.black,
    tabBarTheme: const TabBarTheme(
      labelStyle: TextStyle(fontSize: 18),
       labelColor: Colors.red,
                        unselectedLabelColor: Colors.white,
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: Colors.black,
                        
    ),
    scaffoldBackgroundColor: Colors.black,
    fontFamily: 'SpaceGrotesk',
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      // bodySmall: TextStyle(color: Colors.white),
    ));
