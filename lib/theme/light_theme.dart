import 'package:flutter/material.dart';
import 'package:starlight_utils/starlight_utils.dart';

Color primarycolor = Colors.blue;
ThemeData lighttheme(ThemeData theme, BuildContext context) {
  return theme.copyWith(
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primarycolor,
        foregroundColor: Colors.white,
      ),
      colorScheme: const ColorScheme.light().copyWith(
        primary: primarycolor,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primarycolor,
        foregroundColor: Colors.white,
        elevation: 1,
      ),
      drawerTheme: DrawerThemeData(
          width: context.width * 0.7,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
          backgroundColor: Colors.white),
      // colorScheme: theme.colorScheme.copyWith(
      //   // primary: const Color.fromARGB(255, 6, 125, 230),
      // ),

      textButtonTheme: const TextButtonThemeData(
          style: ButtonStyle(
        foregroundColor: MaterialStatePropertyAll(Colors.blue),
      )),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: const MaterialStatePropertyAll(Colors.white),
          backgroundColor: MaterialStatePropertyAll(primarycolor),
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
          floatingLabelStyle: TextStyle(color: Colors.blue.shade300),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade300),
          ),
          isDense: true,
          border: const OutlineInputBorder()));
}
