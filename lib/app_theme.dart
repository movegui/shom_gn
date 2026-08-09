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
      iconButtonTheme: _iconButtonTheme(),

    textTheme: _textTheme(),
    iconTheme: const IconThemeData(
      color: AppColors.primary,
    ),
       textButtonTheme: _textButtonTheme()
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
    textButtonTheme: _textButtonTheme(),
    iconButtonTheme: _iconButtonTheme(),
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

  static TextButtonThemeData _textButtonTheme (){
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: AppColors.onPrimary, // MoveGui
        foregroundColor: AppColors.primary,

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
        iconColor: AppColors.primary,
        iconSize: 14,
        disabledForegroundColor: AppColors.disabled,
        disabledIconColor: AppColors.disabled,
      ),
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
        disabledIconColor: AppColors.disabled ,
        
      ),
    );
  }

  static IconButtonThemeData _iconButtonTheme() {
  return IconButtonThemeData(
    style: ButtonStyle(
      padding: WidgetStateProperty.all(
        const EdgeInsets.all(8.0),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.hovered)) {
          return AppColors.selectionColor;
        }

        if (states.contains(WidgetState.pressed)) {
          return AppColors.selectionColor;
        }

        return AppColors.primary;
      }),
      foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.hovered)) {
          return AppColors.onPrimary;
        }

        return AppColors.onPrimary;
      }),
      iconSize: WidgetStateProperty.all(20),
    ),
  );
}

 static TextTheme _textTheme() {
    return TextTheme(
      // Titres des pages
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.onPrimary,
      ),

      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.onPrimary,
      ),

      headlineSmall: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColors.onPrimary,
      ),

      // Titres de cards
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: AppColors.onPrimary,
      ),

      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,    
        color: AppColors.onPrimary,
      ),

      // Texte normal
      bodyLarge: TextStyle(
        fontSize: 16,
        color: AppColors.onPrimary,
      ),

      bodyMedium: TextStyle(
        fontSize: 14,
        color: AppColors.onPrimary,
      ),

      bodySmall: TextStyle(
        fontSize: 12,
        color: AppColors.onPrimary, 
      ),

      // Boutons
      labelLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600, 
        color: AppColors.onPrimary,
      ),

      displayLarge: TextStyle(
        fontSize: 24,
        color: AppColors.onPrimary,
      ),
      displayMedium: TextStyle(
        fontSize: 18,
        color: AppColors.onPrimary,
      ),
      displaySmall: TextStyle(
        fontSize: 12,
        color: AppColors.onPrimary,
      ),
    );
  
  }
}
