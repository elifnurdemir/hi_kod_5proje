import 'package:flutter/material.dart';
import 'package:hi_kod_5proje/utils/constants/colors.dart';
import 'package:hi_kod_5proje/utils/constants/sizes.dart';

class AppElevatedButtonTheme {
  AppElevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    elevation: 0,
    foregroundColor: Colors.white,
    backgroundColor: AppColors.deepBlue,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.borderRadiusXLg)),
    iconColor: Colors.white,
    textStyle: const TextStyle(fontSize: AppSizes.fontSizeMd, color: Colors.white, fontWeight: FontWeight.w600),
  ));
}
