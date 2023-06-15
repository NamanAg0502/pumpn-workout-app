import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pumpn/constants/index.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.white,
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.orange,
      textTheme: ButtonTextTheme.primary,
    ),
    scaffoldBackgroundColor: AppColors.white,
    textTheme: GoogleFonts.outfitTextTheme().apply(
      bodyColor: AppColors.white,
    ),
    colorScheme: const ColorScheme(
      background: AppColors.black,
      onBackground: AppColors.black,
      primary: AppColors.orange,
      secondary: AppColors.orange,
      surface: AppColors.orange,
      onPrimary: AppColors.white,
      onSecondary: AppColors.white,
      onSurface: AppColors.white,
      brightness: Brightness.light,
      error: AppColors.red,
      onError: AppColors.white,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.black,
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.orange,
      textTheme: ButtonTextTheme.primary,
    ),
    scaffoldBackgroundColor: AppColors.black,
    textTheme: GoogleFonts.outfitTextTheme().apply(
      bodyColor: AppColors.white,
    ),
    colorScheme: const ColorScheme(
      background: AppColors.black,
      onBackground: AppColors.black,
      primary: AppColors.orange,
      secondary: AppColors.orange,
      surface: AppColors.orange,
      onPrimary: AppColors.white,
      onSecondary: AppColors.white,
      onSurface: AppColors.white,
      brightness: Brightness.dark,
      error: AppColors.red,
      onError: AppColors.white,
    ),
  );
}
