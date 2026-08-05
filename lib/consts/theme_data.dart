import 'package:flutter/material.dart';
import 'package:shom_gn/app_theme.dart';


class Styles {
  static ThemeData themeData(getDarkTheme, {
    required bool isDarkTheme,
    required BuildContext context,
  }) {
    return isDarkTheme ? AppTheme.darkTheme : AppTheme.lightTheme;
  }
}

