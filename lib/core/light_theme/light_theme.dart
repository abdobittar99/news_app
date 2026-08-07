import 'package:flutter/material.dart';
import 'package:news_app/core/light_theme/light_color.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    // primaryContainer: Color(0xffFFFFFF),
    // secondary: Color(0xff3A4640),
  ),
  scaffoldBackgroundColor: Color(0xffF5F5F5),
  primaryColor: LightColor.primaryColor,
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xffFFFFFF),
    // titleTextStyle: TextStyle(
    //   fontSize: 20,
    //   fontWeight: FontWeight.w400,
    //   color: Color(0xff161F1B),
    // ),
    // iconTheme: IconThemeData(color: Color(0xff161F1B)),
  ),

  //   textTheme: TextTheme(
  //     displaySmall: TextStyle(
  //       fontSize: 24,
  //       color: Color(0xff161F1B),
  //       fontWeight: FontWeight.w400,
  //     ),
  //     displayMedium: TextStyle(
  //       fontSize: 28,
  //       color: Color(0xff161F1B),
  //       fontWeight: FontWeight.w400,
  //     ),
  //     displayLarge: TextStyle(
  //       fontSize: 32,
  //       color: Color(0xff161F1B),
  //       fontWeight: FontWeight.w400,
  //     ),
  //     titleSmall: TextStyle(
  //       fontSize: 14,
  //       color: Color(0xff3A4640),
  //       fontWeight: FontWeight.w400,
  //     ),

  //     titleMedium: TextStyle(
  //       fontSize: 16,
  //       color: Color(0xff161F1B),
  //       fontWeight: FontWeight.w400,
  //     ),
  //     //  for Done tasks
  //     titleLarge: TextStyle(
  //       color: Color(0xff6A6A6A),
  //       fontSize: 16.0,
  //       decoration: TextDecoration.lineThrough,
  //       decorationColor: Color(0xff49454F),
  //       overflow: TextOverflow.ellipsis,
  //       fontWeight: FontWeight.w400,
  //     ),
  //     labelSmall: TextStyle(
  //       fontSize: 20,
  //       color: Color(0xff161F1B),
  //       fontWeight: FontWeight.w400,
  //     ),
  //     labelMedium: TextStyle(color: Colors.black, fontSize: 16.0),
  //     labelLarge: TextStyle(color: Colors.black, fontSize: 24.0),
  //   ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Color(0xffD1DAD6), width: 0.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Color(0xffD1DAD6), width: 0.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Color(0xffD1DAD6), width: 0.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Colors.redAccent, width: 0.5),
    ),
    hintStyle: TextStyle(color: Color(0xff9E9E9E)),
    filled: true,
    fillColor: Color(0xffFFFFFF),
    focusColor: Color(0xff9E9E9E),
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xff15B86C);
      }
      return Colors.white;
    }),
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      }
      return Color(0xff9e9e9e);
    }),
    trackOutlineColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.transparent;
      }
      return Color(0xff9e9e9e);
    }),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: LightColor.primaryColor,
      foregroundColor: Color(0xffFFFCFC),
      textStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: Color(0xffc53030)),
  ),
  //   floatingActionButtonTheme: FloatingActionButtonThemeData(
  //     backgroundColor: Color(0xff15B86C),
  //     foregroundColor: Color(0xfffffcfc),
  //     extendedTextStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
  //   ),
  //   checkboxTheme: CheckboxThemeData(
  //     side: BorderSide(color: Color(0xffD1DAD6), width: 2.0),
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadiusGeometry.circular(4.0),
  //     ),
  //   ),
  //   iconTheme: IconThemeData(color: Color(0xff161F1B)),
  //   listTileTheme: ListTileThemeData(
  //     titleTextStyle: TextStyle(
  //       fontSize: 16,
  //       color: Color(0xff161F1B),
  //       fontWeight: FontWeight.w400,
  //     ),
  //   ),
  //   dividerTheme: DividerThemeData(color: Color(0xffD1DAD6)),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Colors.grey[300],
    selectionHandleColor: Colors.black,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: LightColor.backgroundColor,
    selectedItemColor: LightColor.primaryColor,
    unselectedItemColor: Color(0xff363636),
    showUnselectedLabels: true,
  ),

  //   splashFactory: NoSplash.splashFactory,
  //   popupMenuTheme: PopupMenuThemeData(
  //     color: Color(0xffF6F7F9),
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  //     elevation: 3,
  //     shadowColor: Color(0xff15B86C),
  //     labelTextStyle: WidgetStateProperty.all(
  //       TextStyle(
  //         fontSize: 16,
  //         fontWeight: FontWeight.w400,
  //         color: Color(0xff161F1B),
  //       ),
  //     ),
  //   ),
);
