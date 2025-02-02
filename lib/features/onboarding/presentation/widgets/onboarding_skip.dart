import 'package:flutter/material.dart';
import 'package:hi_kod_5proje/features/onboarding/controllers/onboarding_controller.dart';
import 'package:hi_kod_5proje/utils/constants/sizes.dart';
import 'package:hi_kod_5proje/utils/device/device_utility.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: DeviceUtils.getAppBarHeight(),
        right: AppSizes.defaultSpace,
        child: TextButton(
          onPressed: () => OnBoardingController.instance.skipPage(),
          child: const Text("Skip"),
        ));
  }
}
