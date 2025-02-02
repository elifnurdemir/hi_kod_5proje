import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hi_kod_5proje/cards/card.dart';
import 'package:hi_kod_5proje/features/learn/screens/card_detail.dart';
import 'package:hi_kod_5proje/features/quiz/screens/main_quiz.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  // Variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  // Update current index when page scroll
  void updatePageIndicator(index) => currentPageIndex.value = index;

  // Jump to the specific dot selected page
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  // Update current index & jump to next page
  void nextPage() {
    if (currentPageIndex.value == 2) {
      // final storage = GetStorage();
      // storage.write("IsFirstTime", false);
      Get.offAll(const CardWidget());
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  // Update current index & jump to the last page
  void skipPage() {
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }
}
