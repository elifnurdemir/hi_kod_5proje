import 'package:flutter/material.dart';
import 'package:hi_kod_5proje/utils/constants/sizes.dart';

class AppTextFormFieldTheme {
  AppTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: Colors.white.withOpacity(0.2),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusXLg),
      borderSide: BorderSide(color: Colors.transparent),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusXLg),
      borderSide: BorderSide(
        color: Colors.transparent, // Border şeffaf
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusXLg),
      borderSide: BorderSide(
        color: Colors.transparent, // Border şeffaf
      ),
    ),
    hintStyle: TextStyle(
      color: Colors.white, // Beyaz renk
      fontSize: AppSizes.fontSizeMd,
      fontWeight: FontWeight.w400,
    ),
    labelStyle: TextStyle(
      color: Colors.white, // Beyaz renk
      fontSize: AppSizes.fontSizeLg,
      fontWeight: FontWeight.w400,
    ),
    floatingLabelBehavior: FloatingLabelBehavior.never,
    contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20), // İçeriği merkezlemek için padding
  );
}
