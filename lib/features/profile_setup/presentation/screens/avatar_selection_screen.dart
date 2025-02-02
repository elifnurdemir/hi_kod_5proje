import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_kod_5proje/features/profile_setup/controllers/profile_setup_controller.dart';
import 'package:hi_kod_5proje/features/profile_setup/presentation/screens/profile_test.dart';

class AvatarSelectionScreen extends StatefulWidget {
  @override
  _AvatarSelectionScreenState createState() => _AvatarSelectionScreenState();
}

class _AvatarSelectionScreenState extends State<AvatarSelectionScreen> {
  final ProfileSetupController controller = Get.find();
  final List<String> avatars = [
    "assets/images/onboarding_1.png",
    "assets/images/onboarding_1.png",
    "assets/images/onboarding_1.png",
  ];

  int selectedIndex = 0; // Seçili avatarın indexi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Avatar Seçimi")),
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
                      color: isSelected ? Colors.blueAccent : Colors.transparent,
                      width: isSelected ? 4.0 : 0.0,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: Colors.blueAccent.withOpacity(0.3),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ]
                        : [],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Card(
                    elevation: isSelected ? 8 : 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(avatars[index], height: 150),
                        SizedBox(height: 10),
                        Text("Avatar ${index + 1}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                );
              },
              viewportFraction: 0.7,
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
          ElevatedButton(
            onPressed: () {
              controller.setAvatar(avatars[selectedIndex]);
              controller.saveProfile();
              Get.to(ProfileTestScreen()); // Ana ekrana yönlendir
            },
            child: Text("Seç ve Devam Et"),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
