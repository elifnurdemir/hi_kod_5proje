import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_kod_5proje/features/profile/profile_page_data.dart';
import 'package:hi_kod_5proje/features/profile_setup/controllers/profile_setup_controller.dart';
import 'package:hi_kod_5proje/utils/local_storage/storage_utility.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileSetupController controller = Get.find();

  final AppLocalStorage _localStorage = AppLocalStorage();

  final List<String> _badges = [
    "🏅 Adalet Savunucusu ",
    "📚 Bilgi Kaşif",
    "🌍 Hak Savunucusu",
    "🤝 Empati Lideri ",
    "🏆 Şampiyon Çocuk",
  ];

  //Rozetlere göre hakkımda açıklamasını gösterir
  String _getAboutMe() {
    String aboutMe = "Merhaba ben ${controller.userProfile.value.firstName}.";

    if (_badges.contains("🏅 Adalet Savunucusu ")) {
      aboutMe +=
          "Adalet Savunucusu rozetini kazanarak, çocukların adil bir dünyada yaşama hakkını savunma konusundaki kararlılığımı gösterdim. ";
    }
    if (_badges.contains("📚 Bilgi Kaşif")) {
      aboutMe +=
          "Bilgi Kaşifi rozetiyle, çocuk haklarıyla ilgili bilgimi derinleştirdim ve bu konuda farkındalık yaratmaya çalışıyorum ";
    }
    if (_badges.contains("🌍 Hak Savunucusu")) {
      aboutMe += "Hak Savunucusu rozetini alarak, çocukların temel haklarını koruma konusundaki tutkumu kanıtladım. ";
    }
    if (_badges.contains("🤝 Empati Lideri ")) {
      aboutMe += "Empati Lideri rozeti, çocukların duygusal ve sosyal ihtiyaçlarına duyarlı olduğumu gösteriyor. ";
    }
    if (_badges.contains("🏆 Şampiyon Çocuk")) {
      aboutMe +=
          "Tüm bu çabalarımın sonucunda Şampiyon Çocuk rozetini kazanarak, çocuk hakları alanındaki liderliğimi taçlandırdım.";
    }
    aboutMe += "Tüm Rozetleri kazandınız Tebrikler Çocuklarımız hakkını hep birlikle savunalım .";

    return aboutMe;
  }

  void _editProfile() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Profili Düzenle"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: TextEditingController(text: controller.userProfile.value.firstName),
                    decoration: InputDecoration(labelText: "İsim"),
                    onChanged: (value) {
                      controller.userProfile.update((userProfile) {
                        userProfile?.firstName = value;
                      });
                    },
                  ),
                  TextField(
                    controller: TextEditingController(text: controller.userProfile.value.lastName),
                    decoration: InputDecoration(labelText: "Soyisim"),
                    onChanged: (value) {
                      controller.userProfile.update((userProfile) {
                        userProfile?.lastName = value;
                      });
                    },
                  ),
                  TextField(
                    controller: TextEditingController(text: controller.userProfile.value.age.toString()),
                    decoration: InputDecoration(labelText: "Yaş"),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      controller.userProfile.update((userProfile) {
                        userProfile?.age = int.tryParse(value) ?? controller.userProfile.value.age;
                      });
                    },
                  ),
                ],
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("İptal edildi")));
                        Navigator.of(context).pop();
                      },
                      child: Text("İptal"),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Profiliniz güncellendi")));
                  Navigator.of(context).pop();
                },
                child: Text("Kaydet"),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back)),
        title: Center(child: Text("Profilim")),
        actions: [
          IconButton(onPressed: _editProfile, icon: Icon(Icons.edit)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(controller.userProfile.value.avatarUrl),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Text(
                              '${controller.userProfile.value.firstName} ${controller.userProfile.value.lastName}',
                              style: ProjectTextUtility.textStyle),
                        ),
                        SizedBox(child: ProjectSizedBox.sizedbox3),
                        SizedBox(child: ProjectSizedBox.sizedbox3),
                        Obx(
                          () => Text(
                            "Yaş ${controller.userProfile.value.age}",
                            style: ProjectTextUtility.textStyle2,
                          ),
                        ),
                        SizedBox(child: ProjectSizedBox.sizedbox3),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(child: ProjectSizedBox.sizedbox),
              Text("ÖDÜLLER", style: ProjectTextUtility.textStyle),
              SizedBox(child: ProjectSizedBox.sizedbox2),
              Wrap(
                spacing: 10,
                children: _badges.map((badge) {
                  return Chip(
                    label: Text(badge),
                    backgroundColor: Colors.blue[50],
                  );
                }).toList(),
              ),
              SizedBox(child: ProjectSizedBox.sizedbox),
              Text("HAKKIMDA", style: ProjectTextUtility.textStyle),
              SizedBox(
                child: ProjectSizedBox.sizedbox2,
              ),
              Text(
                _getAboutMe(),
                style: ProjectTextUtility.textStyle2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
