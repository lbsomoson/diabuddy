import 'dart:convert';

class Meal {
  final String? mealId;
  final String? mealName;
  final String? foodCode;
  final double? calcium;
  final double? carbohydrate;
  final double? diversityScore;
  final double? energyKcal;
  final double? fat;
  final double? glycemicIndex;
  final double? iron;
  final double? phosphorus;
  final double? protein;

  final String? niacin;
  final String? cholesterol;
  final String? phytochemicalIndex;
  final String? potassium;
  final String? retinol;
  final String? riboflavin;
  final List<String>? sodium;
  final String? thiamin;
  final String? totalDietaryFiber;
  final String? totalSugar;
  final String? vitaminC;
  final String? zinc;
  final String? betaCarotene;

  Meal({
    this.mealId,
    this.mealName,
    this.foodCode,
    this.carbohydrate,
    this.totalDietaryFiber,
    this.totalSugar,
    this.protein,
    this.fat,
    this.energyKcal,
    this.sodium,
    this.cholesterol,
    this.calcium,
    this.phosphorus,
    this.iron,
    this.potassium,
    this.zinc,
    this.retinol,
    this.betaCarotene,
    this.thiamin,
    this.riboflavin,
    this.niacin,
    this.vitaminC,
    this.glycemicIndex,
    this.diversityScore,
    this.phytochemicalIndex,
  });

  factory Meal.fromJson(Map<String, dynamic> json, String id) {
    return Meal(
      mealId: id,
      mealName: json['Meal Name'],
      foodCode: json['Food Code'],
      carbohydrate: json['Carbohydrate']?.toDouble(),
      totalDietaryFiber: json['Total Dietary Fiber'],
      totalSugar: json['Total Sugar'],
      protein: json['Protein']?.toDouble(),
      fat: json['Fat']?.toDouble(),
      energyKcal: json['Energy (Kcal)']?.toDouble(),
      sodium: json['Sodium']?.cast<String>(),
      cholesterol: json['Cholesterol'],
      calcium: json['Calcium']?.toDouble(),
      phosphorus: json['Phosphorus']?.toDouble(),
      iron: json['Iron']?.toDouble(),
      potassium: json['Potassium'],
      zinc: json['Zinc'],
      retinol: json['Retinol'],
      betaCarotene: json['beta-carotene'],
      thiamin: json['Thiamin'],
      riboflavin: json['Riboflavin'],
      niacin: json['Niacin'],
      vitaminC: json['Vitamin C'],
      glycemicIndex: json['Glycemic Index']?.toDouble(),
      diversityScore: json['Diversity Score']?.toDouble(),
      phytochemicalIndex: json['Phytochemical Index'],
    );
  }

  static List<Meal> fromJsonArray(List<Map<String, dynamic>> jsonData) {
    return jsonData.map<Meal>((data) {
      String id = data['mealId'];
      return Meal.fromJson(data, id);
    }).toList();
    // final Iterable<dynamic> data = jsonDecode(jsonData);
    // String id = data['mealId'];
    // return data.map<Meal>((dynamic d) => Meal.fromJson(d, id)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'mealId': mealId,
      'mealName': mealName,
      'foodCode': foodCode,
      'carbohydrate': carbohydrate,
      'totalDietaryFiber': totalDietaryFiber,
      'totalSugar': totalSugar,
      'protein': protein,
      'fat': fat,
      'energyKcal': energyKcal,
      'sodium': sodium,
      'cholesterol': cholesterol,
      'calcium': calcium,
      'phosphorus': phosphorus,
      'iron': iron,
      'potassium': potassium,
      'zinc': zinc,
      'retinol': retinol,
      'betaCarotene': betaCarotene,
      'thiamin': thiamin,
      'riboflavin': riboflavin,
      'niacin': niacin,
      'vitaminC': vitaminC,
      'glycemicIndex': glycemicIndex,
      'diversityScore': diversityScore,
      'phytochemicalIndex': phytochemicalIndex,
    };
  }
}
