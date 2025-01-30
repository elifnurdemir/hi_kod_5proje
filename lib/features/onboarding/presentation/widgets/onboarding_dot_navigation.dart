import 'package:flutter/material.dart';
import 'package:hi_kod_5proje/features/onboarding/presentation/controllers/onboarding_controller.dart';
import 'package:hi_kod_5proje/utils/constants/sizes.dart';
import 'package:hi_kod_5proje/utils/device/device_utility.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingDotNavigation extends StatelessWidget {
  const OnboardingDotNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;

    return Positioned(
        bottom: DeviceUtils.getBottomNavigationBarHeight() + 25,
        left: AppSizes.defaultSpace,
        child: SmoothPageIndicator(
          controller: controller.pageController,
          onDotClicked: controller.dotNavigationClick,
          count: 3,
          effect: ExpandingDotsEffect(activeDotColor: Colors.amber, dotHeight: 6),
        ));
  }
}
