import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hi_kod_5proje/features/profile_setup/presentation/screens/user_info_screen.dart';
import 'package:hi_kod_5proje/utils/local_storage/storage_utility.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();
  final localStorage = AppLocalStorage();

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
  void nextPage() async {
    if (currentPageIndex.value == 2) {
      await localStorage.saveData("IS_FIRST_TIME", false);
      Get.offAll(UserInfoScreen());
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
