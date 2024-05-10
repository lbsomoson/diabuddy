import 'dart:convert';

class Meal {
  final String? mealId;
  String mealName;
  String foodGroup;
  String date;
  int glycemicIndex;
  int carbohydrateContent;
  double calorieContent;
  String remarks;

  Meal({
    this.mealId,
    required this.mealName,
    required this.foodGroup,
    required this.date,
    required this.glycemicIndex,
    required this.carbohydrateContent,
    required this.calorieContent,
    required this.remarks,
  });

  // Factory constructor to instantiate object from json format
  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      mealId: json['mealId'],
      mealName: json['mealName'],
      foodGroup: json['foodGroup'],
      date: json['date'],
      glycemicIndex: json['glycemicIndex'],
      carbohydrateContent: json['carbohydrateContent'],
      calorieContent: json['calorieContent'],
      remarks: json['remarks'],
    );
  }

  static List<Meal> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Meal>((dynamic d) => Meal.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Meal meal) {
    return {
      'mealId': meal.mealId,
      'mealName': meal.mealName,
      'foodGroup': meal.foodGroup,
      'date': meal.date,
      'glycemicIndex': meal.glycemicIndex,
      'carbohydrateContent': meal.carbohydrateContent,
      'calorieContent': meal.calorieContent,
      'remarks': meal.remarks,
    };
  }
}
