import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_kod_5proje/features/onboarding/controllers/onboarding_controller.dart';
import 'package:hi_kod_5proje/features/onboarding/presentation/widgets/onboarding_dot_navigation.dart';
import 'package:hi_kod_5proje/features/onboarding/presentation/widgets/onboarding_next_button.dart';
import 'package:hi_kod_5proje/features/onboarding/presentation/widgets/onboarding_page.dart';
import 'package:hi_kod_5proje/features/onboarding/presentation/widgets/onboarding_skip.dart';
import 'package:hi_kod_5proje/utils/constants/image_strings.dart';
import 'package:hi_kod_5proje/utils/constants/text_strings.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          // Horizontal Scrollable Pages
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: AppImages.onBoardingImage1,
                title: AppTexts.onBoardingTitle1,
                subTitle: AppTexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: AppImages.onBoardingImage2,
                title: AppTexts.onBoardingTitle2,
                subTitle: AppTexts.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                image: AppImages.onBoardingImage2,
                title: AppTexts.onBoardingTitle2,
                subTitle: AppTexts.onBoardingSubTitle2,
              ),
            ],
          ),

          // Skip Button
          const OnBoardingSkip(),

          // Dot Navigation SmoothPageIndicator Change count to the page number
          const OnboardingDotNavigation(),

          // Circular Button
          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}
