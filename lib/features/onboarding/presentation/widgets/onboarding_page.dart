import 'package:flutter/material.dart';
import 'package:hi_kod_5proje/utils/constants/sizes.dart';
import 'package:hi_kod_5proje/utils/helper/helper_functions.dart';
import 'package:lottie/lottie.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.lottieAnimation,
    required this.title,
    required this.subTitle,
  });

  final String lottieAnimation, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.defaultSpace),
      child: Column(
        children: [
          Lottie.asset(
            lottieAnimation,
            width: AppHelperFunctions.screenWidth() * 0.8,
            height: AppHelperFunctions.screenHeight() * 0.6,
            fit: BoxFit.contain,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.displaySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),
          Text(
            subTitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
