import 'package:diabuddy/models/meal_model.dart';

var classNames = {
  'ADOBO': 'Adobo (Pork & Chicken)',
  'ADOBONG_KANGKONG': 'Adobong Kangkong',
  'AFRITADA': 'Afritada',
  'ARROZ_CALDO': 'Arroz Caldo',
  'BANANA_LATUNDAN': 'Banana, Latundan',
  'BANANA_CUE': 'Banana Cue',
  'BANGUS_FRIED': 'Fried Bangus',
  'BANGUS_INIHAW': 'Inihaw na Bangus',
  'BANGUS_RELLENO': 'Rellenong Bangus',
  'BARBEQUE': 'Barbeque',
  'BEEF_STEAK': 'Beef Steak',
  'BICOL_EXPRESS': 'Bicol Express',
  'BULALO': 'Bulalo',
  'BULANLANG': 'Bulanglang',
  'BURGER_STEAK': 'Burger Steak',
  'CALAMARES': 'Calamares',
  'CALDERETA': 'Caldereta',
  'CANNED_TUNA': 'Canned Tuna',
  'CARBONARA': 'Carbonara',
  'CHAMPORADO': 'Champorado',
  'CHEESEBURGER': 'Cheeseburger',
  'CHICKEN_CURRY': 'Chicken Curry',
  'CHICKEN_INASAL': 'Chicken Inasal',
  'CHICKEN_NUGGETS': 'Chicken Nuggets',
  'CHICKEN_TINOLA': 'Chicken Tinola',
  'CHOPSUEY': 'Chopsuey',
  'COFFEE_3IN1': '3-in-1 Coffee',
  'COFFEE_PURE': 'Coffee Instant, 100% Pure',
  'CORDON_BLEU': 'Cordon Bleu',
  'CORNED_BEEF': 'Corned Beef',
  'CRISPY_PATA': 'Crispy Pata',
  'DINENGDENG': 'Dinengdeng',
  'DINUGUAN': 'Dinuguan',
  'EGG_SCRAMBLED': 'Scrambled Egg',
  'EGG_SUNNYSIDEUP': 'Sunny Sideup',
  'FISH_FILLET': 'Fish Fillet',
  'FISHBALL': 'Fishball',
  'FRIED_CHICKEN': 'Fried Chicken',
  'FRIED_PORKCHOP': 'Fried Porkchop',
  'FRIED_TILAPIA': 'Fried Tilapia',
  'FRENCH_FRIES': 'French Fries',
  'GINATAANG_KALABASA_SITAW': 'Ginataang Kalabasa with Sitaw',
  'GINATAANG_LANGKA': 'Ginataang Langka',
  'GINISANG_AMPLAYA': 'Ginisang Ampalaya',
  'GINISANG_PECHAY': 'Ginisang Pechay',
  'GINISANG_TOGUE_TOKWA': 'Ginisang Togue with Tokwa',
  'GINSANG_SAYOTE': 'Ginisang Sayote',
  'GISING_GISING': 'Gising-Gising',
  'GLAZED_DONUT': 'Glazed Donut',
  'HALO_HALO': 'Halo-Halo',
  'HOTDOG': 'Hotdog',
  'ICED_TEA': 'Iced Tea',
  'KANSI': 'Kansi',
  'KARE_KARE': 'Kare-Kare',
  'LAING': 'Laing',
  'LATTE': 'Latte',
  'LECHON_KAWALI': 'Lechon Kawali',
  'LIEMPO_INIHAW': 'Inihaw na Liempo',
  'LONGGANISA': 'Longganisa',
  'LUMPIANG_SARIWA': 'Lumpiang Sariwa',
  'LUMPIANG_SHANGHAI': 'Lumpiang Shanghai',
  'LUMPIANG_TOGUE': 'Lumpiang Togue',
  'MANGO_HINOG_KALABAW': 'Ripe Mango, Kalabaw',
  'MECHADO': 'Mechado',
  'MENUDO': 'Menudo',
  'MISUA_PATOLA_MEATBALLS': 'Misua with Patola and Meatballs',
  'MONGGO': 'Monggo',
  'NILAGANG_BAKA': 'Nilagang Baka',
  'PAKBET': 'Pakbet',
  'PALABOK': 'Palabok',
  'PANDESAL': 'Pandesal',
  'PANSIT_BIHON': 'Pansit Bihon',
  'PESANG_ISDA': 'Pesang Isda',
  'PORK_SINIGANG': 'Pork Sinigang',
  'SWEET_SOUR_PORK': 'Sweet and Sour Pork',
  'PRITONG_TALONG': 'Pritong Talong',
  'PUTO_PUTI_NIYOG': 'Puto Puti, with Niyog',
  'RED_APPLE': 'Red Apple',
  'RICE': 'White Rice',
  'SINANGAG': 'Sinigang',
  'SIOMAI': 'Siomai',
  'SISIG': 'Sisig',
  'SODA': 'Soda',
  'SOPAS': 'Soda',
  'SPAGHETTI': 'Spaghetti',
  'SQUID_BALL': 'Squidball',
  'SUMAN': 'Suman',
  'TAPA': 'Tapa',
  'TOCINO': 'Tocino',
  'TOKWAT_BABOY': 'Tokwa\'t Baboy',
  'TORTANG_TALONG': 'Tortang Talong',
  'TURON': 'Turon',
  'TUYO': 'Tuyo',
  'UKOY': 'Ukoy',
  'BROWN_RICE': 'Brown Rice',
  'CHOCOLATE_CAKE': 'Chocolate Cake',
  'SHAWARMA': 'Shawarma',
  'LECHE FLAN': 'Leche Flan'
};

Meal accumulateMealValues(List<Meal> meals) {
  Meal accMeal = Meal(
      mealId: "",
      mealName: "",
      foodCode: "",
      calcium: 0.0,
      carbohydrate: 0.0,
      diversityScore: 0.0,
      energyKcal: 0.0,
      fat: 0.0,
      glycemicIndex: 0.0,
      iron: 0.0,
      phosphorus: 0.0,
      protein: 0.0,
      healtyEatingIndex: 0.0,
      niacin: 0.0,
      cholesterol: 0.0,
      phytochemicalIndex: 0.0,
      potassium: 0.0,
      retinol: 0.0,
      riboflavin: 0.0,
      sodium: [0.0, 0.0],
      thiamin: 0.0,
      totalDietaryFiber: 0.0,
      totalSugar: 0.0,
      vitaminC: 0.0,
      zinc: 0.0,
      betaCarotene: 0.0,
      heiClassification: "");
  // initialize a string accumulator
  StringBuffer mealNamesBuffer = StringBuffer();
  StringBuffer mealIdsBuffer = StringBuffer();
  StringBuffer mealFoodCodesBuffer = StringBuffer();
  String? heiClassificationBuffer;

  List<String> heiClassificationBufferList = [];

  for (var m in meals) {
    if (!heiClassificationBufferList.contains(m.heiClassification) && m.heiClassification != "") {
      heiClassificationBufferList.add(m.heiClassification!);
    }
  }

  print(heiClassificationBufferList.length);
  for (var c in heiClassificationBufferList) {
    print(c);
  }
  if (heiClassificationBufferList.length == 1) {
    heiClassificationBuffer = heiClassificationBufferList.join("");
  } else if (heiClassificationBufferList.length > 1) {
    heiClassificationBuffer = heiClassificationBufferList.join(", ");
  } else if (heiClassificationBufferList.isEmpty) {
    heiClassificationBuffer = "Unknown";
  }

  for (var m in meals) {
    // accumulate string values, appending ", " where necessary
    if (m.mealName != null && m.mealName!.isNotEmpty) {
      if (mealNamesBuffer.isNotEmpty) {
        mealNamesBuffer.write(", ");
      }
      mealNamesBuffer.write(m.mealName);
    }
    if (m.mealId != null && m.mealId!.isNotEmpty) {
      if (mealIdsBuffer.isNotEmpty) {
        mealIdsBuffer.write(", ");
      }
      mealIdsBuffer.write(m.mealId);
    }
    if (m.foodCode != null && m.foodCode!.isNotEmpty) {
      if (mealFoodCodesBuffer.isNotEmpty) {
        mealFoodCodesBuffer.write(", ");
      }
      mealFoodCodesBuffer.write(m.foodCode);
    }
    accMeal.calcium = ((accMeal.calcium ?? 0.0) + (m.calcium ?? 0.0)).toDouble();
    accMeal.carbohydrate = ((accMeal.carbohydrate ?? 0.0) + (m.carbohydrate ?? 0.0)).toDouble();
    accMeal.diversityScore = ((accMeal.diversityScore ?? 0.0) + (m.diversityScore ?? 0.0)).toDouble();
    accMeal.energyKcal = ((accMeal.energyKcal ?? 0.0) + (m.energyKcal ?? 0.0)).toDouble();
    accMeal.fat = ((accMeal.fat ?? 0.0) + (m.fat ?? 0.0)).toDouble();
    accMeal.glycemicIndex = ((accMeal.glycemicIndex ?? 0.0) + (m.glycemicIndex ?? 0.0)).toDouble();
    accMeal.iron = ((accMeal.iron ?? 0.0) + (m.iron ?? 0.0)).toDouble();
    accMeal.phosphorus = ((accMeal.phosphorus ?? 0.0) + (m.phosphorus ?? 0.0)).toDouble();
    accMeal.healtyEatingIndex = ((accMeal.healtyEatingIndex ?? 0.0) + (m.healtyEatingIndex ?? 0.0)).toDouble();
    accMeal.niacin = ((accMeal.niacin ?? 0.0) + (m.niacin ?? 0.0)).toDouble();
    accMeal.cholesterol = ((accMeal.cholesterol ?? 0.0) + (m.cholesterol ?? 0.0)).toDouble();
    accMeal.phytochemicalIndex = ((accMeal.phytochemicalIndex ?? 0.0) + (m.phytochemicalIndex ?? 0.0)).toDouble();
    accMeal.potassium = ((accMeal.potassium ?? 0.0) + (m.potassium ?? 0.0)).toDouble();
    accMeal.retinol = ((accMeal.retinol ?? 0.0) + (m.retinol ?? 0.0)).toDouble();
    accMeal.riboflavin = ((accMeal.riboflavin ?? 0.0) + (m.riboflavin ?? 0.0)).toDouble();
    accMeal.thiamin = ((accMeal.thiamin ?? 0.0) + (m.thiamin ?? 0.0)).toDouble();
    accMeal.totalDietaryFiber = ((accMeal.totalDietaryFiber ?? 0.0) + (m.totalDietaryFiber ?? 0.0)).toDouble();
    accMeal.totalSugar = ((accMeal.totalSugar ?? 0.0) + (m.totalSugar ?? 0.0)).toDouble();
    accMeal.vitaminC = ((accMeal.vitaminC ?? 0.0) + (m.vitaminC ?? 0.0)).toDouble();
    accMeal.zinc = ((accMeal.zinc ?? 0.0) + (m.zinc ?? 0.0)).toDouble();
    accMeal.betaCarotene = ((accMeal.betaCarotene ?? 0.0) + (m.betaCarotene ?? 0.0)).toDouble();
    accMeal.sodium![0] = (accMeal.sodium?[0] ?? 0.0) + (m.sodium?[0] ?? 0.0);
    accMeal.sodium![1] = (accMeal.sodium?[1] ?? 0.0) + (m.sodium?[1] ?? 0.0);
  }

  accMeal.mealName = mealNamesBuffer.toString();
  accMeal.mealId = mealIdsBuffer.toString();
  accMeal.foodCode = mealFoodCodesBuffer.toString();
  accMeal.heiClassification = heiClassificationBuffer;

  return accMeal;
}
