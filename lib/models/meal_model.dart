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
  final double? healtyEatingIndex;
  final double? niacin;
  final double? cholesterol;
  final double? phytochemicalIndex;
  final double? potassium;
  final double? retinol;
  final double? riboflavin;
  final List<double>? sodium;
  final double? thiamin;
  final double? totalDietaryFiber;
  final double? totalSugar;
  final double? vitaminC;
  final double? zinc;
  final double? betaCarotene;
  final String? heiClassification;

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
    this.healtyEatingIndex,
    this.heiClassification,
  });

  factory Meal.fromJson(Map<String, dynamic> json, String id) {
    return Meal(
      mealId: id,
      mealName: json['Meal Name'],
      foodCode: json['Food Code'],
      carbohydrate: json['Carbohydrate']?.toDouble(),
      totalDietaryFiber: json['Total Dietary Fiber']?.toDouble(),
      totalSugar: json['Total Sugar']?.toDouble(),
      protein: json['Protein']?.toDouble(),
      fat: json['Fat']?.toDouble(),
      energyKcal: json['Energy (Kcal)']?.toDouble(),
      sodium: json['Sodium']?.cast<double>(),
      cholesterol: json['Cholesterol']?.toDouble(),
      calcium: json['Calcium']?.toDouble(),
      phosphorus: json['Phosphorus']?.toDouble(),
      iron: json['Iron']?.toDouble(),
      potassium: json['Potassium']?.toDouble(),
      zinc: json['Zinc']?.toDouble(),
      retinol: json['Retinol']?.toDouble(),
      betaCarotene: json['beta-carotene']?.toDouble(),
      thiamin: json['Thiamin']?.toDouble(),
      riboflavin: json['Riboflavin']?.toDouble(),
      niacin: json['Niacin']?.toDouble(),
      vitaminC: json['Vitamin C']?.toDouble(),
      glycemicIndex: json['Glycemic Index']?.toDouble(),
      diversityScore: json['Diversity Score']?.toDouble(),
      phytochemicalIndex: json['Phytochemical Index']?.toDouble(),
      healtyEatingIndex: json['Healthy Eating Index']?.toDouble(),
      heiClassification: json['HEI Classification'],
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
      'healtyEatingIndex': healtyEatingIndex,
      'heiClassification': heiClassification,
    };
  }
}
