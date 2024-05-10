import 'dart:convert';

class User {
  final String? userId;
  String name;
  int age;
  String activityLevel;
  double height;
  double weight;
  int dailyGlycemicIndex;

  User({
    this.userId,
    required this.name,
    required this.age,
    required this.activityLevel,
    required this.height,
    required this.weight,
    required this.dailyGlycemicIndex,
  });

  // Factory constructor to instantiate object from json format
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
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
      'name': medication.name,
      'age': medication.age,
      'activityLevel': medication.activityLevel,
      'height': medication.height,
      'weight': medication.weight,
      'dailyGlycemicIndex': medication.dailyGlycemicIndex,
    };
  }
}
