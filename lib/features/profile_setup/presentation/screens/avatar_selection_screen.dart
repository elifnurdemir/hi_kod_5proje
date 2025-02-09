import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_kod_5proje/components/Layout.dart';
import 'package:hi_kod_5proje/features/profile_setup/controllers/profile_setup_controller.dart';
import 'package:hi_kod_5proje/features/profile_setup/presentation/screens/profile_test.dart';
import 'package:hi_kod_5proje/utils/constants/colors.dart';
import 'package:hi_kod_5proje/utils/constants/sizes.dart';

class AvatarSelectionScreen extends StatefulWidget {
  @override
  _AvatarSelectionScreenState createState() => _AvatarSelectionScreenState();
}

class _AvatarSelectionScreenState extends State<AvatarSelectionScreen> {
  final ProfileSetupController controller = Get.find();
  final List<String> avatars = [
    "assets/images/avatar_images/erkek_avatar_1.jpg",
    "assets/images/avatar_images/kadin_avatar_1.jpg",
    "assets/images/avatar_images/erkek_avatar_2.jpg",
    "assets/images/avatar_images/kadin_avatar_2.jpg",
    "assets/images/avatar_images/erkek_avatar_3.jpg",
    "assets/images/avatar_images/kadin_avatar_3.jpg",
  ];

  int selectedIndex = 0; // Seçili avatarın indexi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Karakterler")),
      backgroundColor: AppColors.cottonBall,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Swiper(
              itemCount: avatars.length,
              itemBuilder: (context, index) {
                bool isSelected = index == selectedIndex;

                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  padding: EdgeInsets.all(isSelected ? 8.0 : 0.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected ? AppColors.sunnyCoin.withOpacity(0.7) : Colors.transparent,
                      width: isSelected ? 4.0 : 0.0,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppColors.moneyOrange.withOpacity(0.2),
                              blurRadius: 20,
                              spreadRadius: 1,
                            ),
                          ]
                        : [],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Card(
                    elevation: isSelected ? 8 : 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15), // Köşeleri yumuşatır
                      child: Image.asset(
                        avatars[index],
                        fit: BoxFit.cover, // Tüm kartı kaplamasını sağlar
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                );
              },
              viewportFraction: 0.9,
              scale: 0.9,
              loop: false,
              onIndexChanged: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
            child: SizedBox(
              width: double.infinity,
              height: AppSizes.buttonHeightLg,
              child: ElevatedButton(
                onPressed: () {
                  controller.setAvatar(avatars[selectedIndex]);
                  controller.saveProfile();
                  Get.to(Layout()); // Ana ekrana yönlendir
                },
                child: Text("Karakterini Seç"),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
