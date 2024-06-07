import 'dart:convert';

class Meal {
  final String? mealId;
  final String? mealName;
  final String? foodCode;
  final double? carbohydrate;
  final double? totalDietaryFiber;
  final double? totalSugar;
  final double? protein;
  final double? fat;
  final int? energyKcal;
  final List<String>? sodium;
  final String? cholesterol;
  final int? calcium;
  final int? phosphorus;
  final double? iron;
  final String? potassium;
  final String? zinc;
  final String? retinol;
  final String? betaCarotene;
  final String? thiamin;
  final String? riboflavin;
  final String? niacin;
  final String? vitaminC;
  final int? glycemicIndex;
  final int? diversityScore;
  final String? phytochemicalIndex;

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

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      mealId: json['mealId'],
      mealName: json['Meal Name'],
      foodCode: json['Food Code'],
      carbohydrate: json['Carbohydrate']?.toDouble(),
      totalDietaryFiber: json['Total Dietary Fiber']?.toDouble(),
      totalSugar: json['Total Sugar']?.toDouble(),
      protein: json['Protein']?.toDouble(),
      fat: json['Fat']?.toDouble(),
      energyKcal: json['Energy (Kcal)'],
      sodium: json['Sodium']?.cast<String>(),
      cholesterol: json['Cholesterol'],
      calcium: json['Calcium'],
      phosphorus: json['Phosphorus'],
      iron: json['Iron']?.toDouble(),
      potassium: json['Potassium'],
      zinc: json['Zinc'],
      retinol: json['Retinol'],
      betaCarotene: json['beta-carotene'],
      thiamin: json['Thiamin'],
      riboflavin: json['Riboflavin'],
      niacin: json['Niacin'],
      vitaminC: json['Vitamin C'],
      glycemicIndex: json['Glycemic Index'],
      diversityScore: json['Diversity Score'],
      phytochemicalIndex: json['Phytochemical Index'],
    );
  }

  static List<Meal> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Meal>((dynamic d) => Meal.fromJson(d)).toList();
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
