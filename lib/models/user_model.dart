import 'dart:convert';

class AppUser {
  final String? userId;
  String? name;
  String? email;
  int? age;
  String? gender;
  String? activityLevel;
  double? height;
  double? weight;
  int? dailyGlycemicIndex;

  AppUser({
    this.userId,
    this.email,
    this.name,
    this.age,
    this.gender,
    this.activityLevel,
    this.height,
    this.weight,
    this.dailyGlycemicIndex,
  });

  // Factory constructor to instantiate object from json format
  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      userId: json['userId'],
      email: json['email'],
      name: json['name'],
      age: json['age'],
      gender: json['gender'],
      activityLevel: json['activityLevel'],
      height: json['height'],
      weight: json['weight'],
      dailyGlycemicIndex: json['dailyGlycemicIndex'],
    );
  }

  static List<AppUser> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<AppUser>((dynamic d) => AppUser.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(AppUser appuser) {
    return {
      'userId': appuser.userId,
      'email': appuser.email,
      'name': appuser.name,
      'age': appuser.age,
      'gender': appuser.gender,
      'activityLevel': appuser.activityLevel,
      'height': appuser.height,
      'weight': appuser.weight,
      'dailyGlycemicIndex': appuser.dailyGlycemicIndex,
    };
  }
}
