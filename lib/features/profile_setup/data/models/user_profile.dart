class UserProfile {
  String firstName;
  String lastName;
  int age;
  String avatarUrl;

  UserProfile({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.avatarUrl,
  });

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "age": age,
        "avatarUrl": avatarUrl,
      };

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
      age: json["age"] ?? 0,
      avatarUrl: json["avatarUrl"] ?? "",
    );
  }
}
