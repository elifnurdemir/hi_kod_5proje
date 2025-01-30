import 'package:flutter/material.dart';
import 'package:hi_kod_5proje/features/onboarding/presentation/controllers/onboarding_controller.dart';
import 'package:hi_kod_5proje/utils/constants/sizes.dart';
import 'package:hi_kod_5proje/utils/device/device_utility.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: AppSizes.defaultSpace,
        bottom: DeviceUtils.getBottomNavigationBarHeight(),
        child: ElevatedButton(
            onPressed: () => OnBoardingController.instance.nextPage(),
            style: ElevatedButton.styleFrom(shape: const CircleBorder(), backgroundColor: Colors.white),
            child: const Icon(
              Icons.arrow_forward_ios_rounded,
            )));
  }
}
