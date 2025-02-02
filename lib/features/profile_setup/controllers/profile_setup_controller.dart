import 'package:get/get.dart';
import 'package:hi_kod_5proje/features/profile_setup/data/models/user_profile.dart';
import 'package:hi_kod_5proje/utils/local_storage/storage_utility.dart';

class ProfileSetupController extends GetxController {
  var userProfile = UserProfile(firstName: "", lastName: "", age: 0, avatarUrl: "").obs;
  final _localStorage = AppLocalStorage();

  void setFirstName(String value) => userProfile.update((val) => val!.firstName = value);
  void setLastName(String value) => userProfile.update((val) => val!.lastName = value);
  void setAge(int value) => userProfile.update((val) => val!.age = value);
  void setAvatar(String value) => userProfile.update((val) => val!.avatarUrl = value);

  Future<void> saveProfile() async {
    await _localStorage.saveData("userProfile", userProfile.value.toJson());
  }

  void loadProfile() {
    var data = _localStorage.readData<Map<String, dynamic>>("userProfile");
    if (data != null) {
      userProfile.value = UserProfile.fromJson(data);
    }
  }

  Future<void> clearProfile() async {
    await _localStorage.removeData("userProfile");
    userProfile.value = UserProfile(firstName: "", lastName: "", age: 0, avatarUrl: "");
  }
}
