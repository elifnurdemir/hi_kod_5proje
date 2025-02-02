import 'package:flutter/material.dart';
import 'package:hi_kod_5proje/utils/constants/colors.dart';
import 'package:hi_kod_5proje/utils/constants/sizes.dart';

class AppTextButtonTheme {
  AppTextButtonTheme._();

  static final lightTextButtonTheme = TextButtonThemeData(
      style: TextButton.styleFrom(
    elevation: 0,
    foregroundColor: Colors.white,
    backgroundColor: AppColors.moneyOrange,
    textStyle: const TextStyle(fontSize: AppSizes.fontSizeLg, color: Colors.white, fontWeight: FontWeight.w600),
  ));
}
