import 'dart:convert';

class User {
  final String? userId;
  String? name;
  String? email;
  int? age;
  String? activityLevel;
  double? height;
  double? weight;
  int? dailyGlycemicIndex;

  User({
    this.userId,
    this.email,
    this.name,
    this.age,
    this.activityLevel,
    this.height,
    this.weight,
    this.dailyGlycemicIndex,
  });

  // Factory constructor to instantiate object from json format
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      email: json['email'],
      name: json['name'],
      age: json['age'],
      activityLevel: json['activityLevel'],
      height: json['height'],
      weight: json['weight'],
      dailyGlycemicIndex: json['dailyGlycemicIndex'],
    );
  }

  static List<User> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<User>((dynamic d) => User.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(User medication) {
    return {
      'userId': medication.userId,
      'email': medication.email,
      'name': medication.name,
      'age': medication.age,
      'activityLevel': medication.activityLevel,
      'height': medication.height,
      'weight': medication.weight,
      'dailyGlycemicIndex': medication.dailyGlycemicIndex,
    };
  }
}
