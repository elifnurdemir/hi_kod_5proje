import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_kod_5proje/features/profile_setup/controllers/profile_setup_controller.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:hi_kod_5proje/features/profile_setup/presentation/screens/avatar_selection_screen.dart';

class UserInfoScreen extends StatelessWidget {
  UserInfoScreen({super.key});
  final ProfileSetupController controller = Get.put(ProfileSetupController());
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profil Bilgileri")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // İsim Girme Alanı
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(labelText: "İsim"),
              onChanged: controller.setFirstName,
            ),
            const SizedBox(height: 16),

            // Soyisim Girme Alanı
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(labelText: "Soyisim"),
              onChanged: controller.setLastName,
            ),
            const SizedBox(height: 16),

            // Yaş Seçme Butonu
            Obx(() => ElevatedButton(
                  onPressed: () => _showAgePicker(context),
                  child: Text(
                    controller.userProfile.value.age == 0 ? "Yaş Seç" : "Yaş: ${controller.userProfile.value.age}",
                  ),
                )),
            const Spacer(),

            // Devam Butonu
            ElevatedButton(
              onPressed: () {
                if (controller.userProfile.value.firstName.isNotEmpty &&
                    controller.userProfile.value.lastName.isNotEmpty &&
                    controller.userProfile.value.age > 0) {
                  Get.to(() => AvatarSelectionScreen());
                } else {
                  Get.snackbar("Hata", "Lütfen tüm bilgileri doldurun!", snackPosition: SnackPosition.BOTTOM);
                }
              },
              child: const Text("Devam"),
            ),
          ],
        ),
      ),
    );
  }

  void _showAgePicker(BuildContext context) {
    BottomPicker(
      pickerTitle: Text('Yaşınızı Seçin'),
      items: List.generate(100, (index) => Text("${index + 1}")), // 1 ile 100 yaş arasında seçim
      onSubmit: (index) {
        controller.setAge(index + 1);
      },
    ).show(context);
  }
}
