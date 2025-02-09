import 'package:flutter/material.dart';
import 'package:hi_kod_5proje/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:hi_kod_5proje/utils/theme/custom_themes/text_button_theme.dart';
import 'package:hi_kod_5proje/utils/theme/custom_themes/text_form_field_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    textButtonTheme: AppTextButtonTheme.lightTextButtonTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: AppTextFormFieldTheme.lightInputDecorationTheme,
  );
}
