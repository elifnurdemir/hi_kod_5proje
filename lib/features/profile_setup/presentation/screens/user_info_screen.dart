import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_kod_5proje/features/profile_setup/controllers/profile_setup_controller.dart';
import 'package:hi_kod_5proje/features/profile_setup/presentation/screens/avatar_selection_screen.dart';
import 'package:hi_kod_5proje/utils/constants/colors.dart';
import 'package:hi_kod_5proje/utils/constants/sizes.dart';
import 'package:numberpicker/numberpicker.dart';

class UserInfoScreen extends StatelessWidget {
  UserInfoScreen({super.key});
  final ProfileSetupController controller = Get.put(ProfileSetupController());
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.cottonBall,
      body: Padding(
        padding: const EdgeInsets.only(top: AppSizes.appBarHeight),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Hadi, Kim Olduğunu Göster!",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: AppColors.deepBlue, fontWeight: FontWeight.bold)),
            SizedBox(height: AppSizes.smallSpace),
            Text("İsmini, soyismini ve yaşını yaz, seni tanıyalım!",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: AppColors.deepBlue, fontWeight: FontWeight.w400)),
            SizedBox(height: AppSizes.spaceBtwItems),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(AppSizes.defaultSpace),
                color: AppColors.moneyOrange,
                height: double.infinity,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Text(
                          "İsmin",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: AppSizes.fontSizeMd,
                          ),
                        ),
                        SizedBox(height: AppSizes.smallSpace),
                        TextFormField(
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: AppSizes.fontSizeLg,
                          ),
                          controller: firstNameController,
                          decoration: const InputDecoration(label: Center(child: Text("İsmini Gir"))),
                          onChanged: controller.setFirstName,
                        ),
                        const SizedBox(height: 16),
                        Text("Soyismin",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: AppSizes.fontSizeMd,
                            )),
                        SizedBox(height: AppSizes.smallSpace),
                        TextFormField(
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: AppSizes.fontSizeLg,
                          ),
                          controller: lastNameController,
                          decoration: const InputDecoration(label: Center(child: Text("Soyismini Gir"))),
                          onChanged: controller.setLastName,
                        ),
                        const SizedBox(height: AppSizes.spaceBtwItems),
                        Text("Yaşın",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: AppSizes.fontSizeMd,
                            )),
                        SizedBox(height: AppSizes.smallSpace),
                        Obx(
                          () => NumberPicker(
                            value: controller.userProfile.value.age,
                            minValue: 3,
                            maxValue: 99,
                            onChanged: controller.setAge,
                            axis: Axis.horizontal,
                            haptics: true,
                            textStyle: TextStyle(color: AppColors.deepBlue, fontSize: AppSizes.fontSizeLg),
                            selectedTextStyle: TextStyle(color: Colors.white, fontSize: AppSizes.fontSizeXLg),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
                              color: Colors.white.withOpacity(0.2), // Arka plan rengi
                            ),
                          ),
                        ),
                        Container(
                          width: 350,
                          height: 290,
                          alignment: Alignment.center,
                          child: DefaultTextStyle(
                            style: GoogleFonts.pacifico(
                              fontSize: 40,
                              color: Colors.white,
                            ),
                            child: AnimatedTextKit(
                              animatedTexts: [
                                TypewriterAnimatedText('Çocuk Hakları', textAlign: TextAlign.center),
                                TypewriterAnimatedText('Eğitim Hakkı', textAlign: TextAlign.center),
                                TypewriterAnimatedText('Sağlık Hakkı', textAlign: TextAlign.center),
                                TypewriterAnimatedText('Eşitlik Hakkı', textAlign: TextAlign.center),
                                TypewriterAnimatedText('Sevgi ve Aile Hakkı', textAlign: TextAlign.center),
                                TypewriterAnimatedText('Güvende Olma Hakkı', textAlign: TextAlign.center),
                                TypewriterAnimatedText('Oyun ve Dinlenme Hakkı', textAlign: TextAlign.center),
                                TypewriterAnimatedText('Düşüncelerini Söyleme Hakkı', textAlign: TextAlign.center),
                                TypewriterAnimatedText('Temiz Çevrede Yaşama Hakkı', textAlign: TextAlign.center),
                              ],
                              repeatForever: true,
                            ),
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: double.infinity,
                          height: AppSizes.buttonHeightLg,
                          child: ElevatedButton(
                            onPressed: () {
                              if (controller.userProfile.value.firstName.isNotEmpty &&
                                  controller.userProfile.value.lastName.isNotEmpty &&
                                  controller.userProfile.value.age > 0) {
                                Get.to(() => AvatarSelectionScreen());
                              } else {
                                Get.snackbar("Hata", "Lütfen tüm bilgileri doldurun!",
                                    snackPosition: SnackPosition.BOTTOM);
                              }
                            },
                            child: const Text("Devam Et"),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
