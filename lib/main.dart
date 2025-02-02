import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hi_kod_5proje/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:hi_kod_5proje/utils/theme/theme.dart';

Future<void> main() async {
  // GetX Local Storage
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'The App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: OnBoardingScreen(),
    );
  }
}
