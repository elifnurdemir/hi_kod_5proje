import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_kod_5proje/features/profile_setup/controllers/profile_setup_controller.dart';
import 'package:hi_kod_5proje/features/profile_setup/data/models/user_profile.dart';
import 'package:hi_kod_5proje/utils/local_storage/storage_utility.dart';

class ProfileTestScreen extends StatelessWidget {
  final ProfileSetupController controller = Get.find();
  final AppLocalStorage _localStorage = AppLocalStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil Testi"),
      ),
      body: Center(
        child: FutureBuilder(
          future: _loadProfileData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Text("Veri yüklenemedi: ${snapshot.error}");
            }

            // Profil verisi başarıyla yüklendiyse:
            return Obx(
              () => controller.userProfile.value.firstName.isNotEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextField(
                          controller: null,
                          decoration: InputDecoration(labelText: "İsim"),
                          onChanged: controller.setFirstName,
                        ),
                        Text(
                          "İsim: ${controller.userProfile.value.firstName}",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          "Soyisim: ${controller.userProfile.value.lastName}",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          "Yaş: ${controller.userProfile.value.age}",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          "Seçilen Avatar: ${controller.userProfile.value.avatarUrl.isNotEmpty ? controller.userProfile.value.avatarUrl : "Avatar Seçilmedi"}",
                          style: TextStyle(fontSize: 20),
                        ),
                        Image.asset('${controller.userProfile.value.avatarUrl}', height: 100),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            controller.clearProfile();
                            _localStorage.removeData("userProfile");
                            Get.snackbar("Başarılı", "Profil verisi sıfırlandı");
                          },
                          child: Text("Profil Verisini Sıfırla"),
                        ),
                      ],
                    )
                  : Text("Henüz profil verisi bulunmamaktadır."),
            );
          },
        ),
      ),
    );
  }

  Future<void> _loadProfileData() async {
    // Veriyi localStorage'dan yükle
    var data = await _localStorage.readData<Map<String, dynamic>>("userProfile");

    if (data != null) {
      controller.userProfile.value = UserProfile.fromJson(data);
    } else {
      throw Exception("Profil verisi bulunamadı.");
    }
  }
}
