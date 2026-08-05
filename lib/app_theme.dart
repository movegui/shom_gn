import 'package:flutter/material.dart';
import 'package:shom_gn/consts/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    scaffoldBackgroundColor: AppColors.lightBackground,

    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      surface: AppColors.card,
      onSurface: AppColors.primary,
      error: AppColors.error,
    ),

    cardTheme: _cardTheme(),

    inputDecorationTheme: _textFieldTheme(),

    elevatedButtonTheme: _elevatedButtonTheme(),

    textTheme: _textTheme(),
    iconTheme: const IconThemeData(
      color: AppColors.primary,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,

    scaffoldBackgroundColor: AppColors.darkBackground,

    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      surface: AppColors.card,
      onSurface: AppColors.primary,
      error: AppColors.error,
    ),

    cardTheme: _cardTheme(),

    inputDecorationTheme: _textFieldTheme(),

    elevatedButtonTheme: _elevatedButtonTheme(),

    textTheme: _textTheme(),
  );
  

  static CardThemeData _cardTheme() {
    return CardThemeData(
      color: AppColors.card,
      elevation: 3,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }

  static InputDecorationTheme _textFieldTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,

      contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),

      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary),
        borderRadius: BorderRadius.circular(8),
      ),

      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary),
        borderRadius: BorderRadius.circular(8),
      ),

      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.selectionColor, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),

      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.error),
        borderRadius: BorderRadius.circular(8),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.error, width: 2),
      ),

      labelStyle: const TextStyle(color: AppColors.primary),
      hintStyle: const TextStyle(color: AppColors.disabled),
      errorStyle: const TextStyle(color: AppColors.error),
      prefixIconColor: AppColors.primary,
    );
  }


  static ElevatedButtonThemeData _elevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary, // MoveGui
        foregroundColor: AppColors.onPrimary,

        elevation: 3,

        minimumSize: const Size(0, 50),

        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),

        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        iconColor: AppColors.onPrimary,
        iconSize: 14,
        disabledForegroundColor: AppColors.disabled,
        disabledIconColor: AppColors.disabled 
      ),
    );
  }

 static TextTheme _textTheme() {
    return TextTheme(
      // Titres des pages
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold
      ),

      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),

      // Titres de cards
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),

      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),

      // Texte normal
      bodyLarge: TextStyle(
        fontSize: 16,
      ),

      bodyMedium: TextStyle(
        fontSize: 14,
      ),

      bodySmall: TextStyle(
        fontSize: 12,
      ),

      // Boutons
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  
  }
}
