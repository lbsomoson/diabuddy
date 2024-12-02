class Meal {
  String? mealId;
  String? mealName;
  String? foodCode;
  double? calcium;
  double? carbohydrate;
  double? diversityScore;
  double? energyKcal;
  double? fat;
  double? glycemicIndex;
  double? iron;
  double? phosphorus;
  double? protein;
  double? healtyEatingIndex;
  double? niacin;
  double? cholesterol;
  double? phytochemicalIndex;
  double? potassium;
  double? retinol;
  double? riboflavin;
  List<double?>? sodium;
  double? thiamin;
  double? totalDietaryFiber;
  double? totalSugar;
  double? vitaminC;
  double? zinc;
  double? betaCarotene;
  String? heiClassification;

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
    Meal m = Meal(
      mealId: id,
      mealName: json['mealName'] ?? json['Meal Name'],
      foodCode: json['foodCode'] ?? json['Food Code'],
      carbohydrate: json['carbohydrate']?.toDouble() ?? json['Carbohydrate']?.toDouble(),
      totalDietaryFiber: json['totalDietaryFiber']?.toDouble() ?? json['Total Dietary Fiber']?.toDouble(),
      totalSugar: json['totalSugar']?.toDouble() ?? json['Total Sugar']?.toDouble(),
      protein: json['protein']?.toDouble() ?? json['Protein']?.toDouble(),
      fat: json['fat']?.toDouble() ?? json['Fat']?.toDouble(),
      energyKcal: json['energyKcal']?.toDouble() ?? json['Energy (Kcal)']?.toDouble(),
      sodium: json['sodium'] != null ? List<double?>.from(json['sodium']) : null,
      cholesterol: json['cholesterol']?.toDouble() ?? json['Cholesterol']?.toDouble(),
      calcium: json['calcium']?.toDouble() ?? json['Calcium']?.toDouble(),
      phosphorus: json['phosphorus']?.toDouble() ?? json['Phosphorus']?.toDouble(),
      iron: json['iron']?.toDouble() ?? json['Iron']?.toDouble(),
      potassium: json['potassium']?.toDouble() ?? json['Potassium']?.toDouble(),
      zinc: json['zinc']?.toDouble() ?? json['Zinc']?.toDouble(),
      retinol: json['retinol']?.toDouble() ?? json['Retinol']?.toDouble(),
      betaCarotene: json['betaCarotene']?.toDouble() ?? json['beta-carotene']?.toDouble(),
      thiamin: json['thiamin']?.toDouble() ?? json['Thiamin']?.toDouble(),
      riboflavin: json['riboflavin']?.toDouble() ?? json['Riboflavin']?.toDouble(),
      niacin: json['niacin']?.toDouble() ?? json['Niacin']?.toDouble(),
      vitaminC: json['vitaminC']?.toDouble() ?? json['Vitamin C']?.toDouble(),
      glycemicIndex: json['glycemicIndex']?.toDouble() ?? json['Glycemic Index']?.toDouble(),
      diversityScore: json['diversityScore']?.toDouble() ?? json['Diversity Score']?.toDouble(),
      phytochemicalIndex: json['phytochemicalIndex']?.toDouble() ?? json['Phytochemical Index']?.toDouble(),
      healtyEatingIndex: json['healtyEatingIndex']?.toDouble() ?? json['Healthy Eating Index']?.toDouble(),
      heiClassification: json['heiClassification'] ?? json['HEI Classification'],
    );
    return m;
  }

  static List<Meal> fromJsonArray(List<Map<String, dynamic>> jsonData) {
    return jsonData.map<Meal>((data) {
      String id = data['mealId'];
      return Meal.fromJson(data, id);
    }).toList();
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

  Map<String, dynamic> toMap() {
    return {
      'mealName': mealName,
      'foodCode': foodCode,
      'carbohydrate': carbohydrate,
      'totalDietaryFiber': totalDietaryFiber,
      'totalSugar': totalSugar,
      'protein': protein,
      'fat': fat,
      'energyKcal': energyKcal,
      'sodium': sodium!.join(', '),
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
