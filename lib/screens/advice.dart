// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'dart:math';

class AdviceScreen extends StatefulWidget {
  final bool? isBmiUnderweight, isBmiNormal, isBmiObese, isNormalPhysicalActivity;
  const AdviceScreen(
      {this.isBmiNormal, this.isBmiObese, this.isBmiUnderweight, this.isNormalPhysicalActivity, super.key});

  @override
  State<AdviceScreen> createState() => _AdviceScreenState();
}

class _AdviceScreenState extends State<AdviceScreen> {
  List<String> bmi_underweight = [];
  List<String> bmi_normal = [
    "Follow a healthy eating plan through the Pinggang Pinoy by:\nEmphasize vegetables, fruits, whole grains, and fat-free or low-fat dairy products, including lean meats, poultry, fish, beans, eggs, and nuts. Lessen saturated and trans fats, sodium, and added sugars. Apply Portion Size",
    "150 minutes of moderate to vigorous physical activity per week",
    "Keep track of your meals by having a food diary.",
    "Consult a registered nutritionist-dietitian",
  ];
  List<String> bmi_obese = [
    "Follow a healthy eating plan through the Pinggang Pinoy by:\nEmphasize vegetables, fruits, whole grains, and fat-free or low-fat dairy products, including lean meats, poultry, fish, beans, eggs, and nuts. Lessen saturated and trans fats, sodium, and added sugars. Apply Portion Size",
    "300 - 450 minutes of moderate to vigorous physical activity per week",
    "Keep track of your meals by having a food diary.",
    "Consult a registered nutritionist-dietitian",
  ];
  List<String> physical_activity = [
    "Aim for at least 300 - 450 minutes of moderate activity weekly.",
    "Move 1-2 minutes every hour to reduce sedentary activity.	Move 1-2 minutes every hour to reduce sedentary activity.",
    "Follow a varied physical routine for overall fitness health:\nCardiovascular Endurance: Cardio exercises such as walking, jogging, swimming, riding a bike, dancing, etc.\nMuscular Strength: Lifting weights, using resistance bands, climbing stairs, heavy gardening, etc. \nBone Strength: Weight-bearing exercise such as brisk walking, jogging, badminton, climbing stairs, etc.; Resistance training such as lifting weights and body exercises such as push ups or pull ups; and balance training.\nBalance: Weight shift, tai chi, etc.\nFlexibility: Stretching, yoga, pilates, etc.",
    "Monitor your fitness journey by having a physical activity journal.",
    "Consult a registered nutritionist-dietitian, physical therapist or doctor."
  ];
  String normal_physical_activity =
      "Physical Activity	Aim for at least 150 minutes of moderate activity weekly.	Aim for at least 300 - 450 minutes of moderate activity weekly.";
  List<String> dietary_assessment = [
    "Follow the Pinggang Pinoy by:\nFilling half of your plate with fruits and vegetables, ⅔ for grains, bread, pasta, etc. and ⅓ for protein."
        "\nMake healthier food choices when dining out by:\nWhole-grain options like whole wheat bread or brown rice\nMeals with fruits and vegetables\nLean proteins like grilled chicken or baked fish\nLessen the use of condiments 	Make healthier food choices when dining out by:\nWhole-grain options like whole wheat bread or brown rice\nMeals with fruits and vegetables\nLean proteins like grilled chicken or baked fish\nLessen the use of condiments \nCook at home to improve health as home-cooked meals typically include more fruits, vegetables, and fiber, while reducing your intake of salt and saturated fat.	Cook at home to improve health as home-cooked meals typically include more fruits, vegetables, and fiber, while reducing your intake of salt and saturated fat.",
    "Pre-portion snacks to avoid overeating.",
    "Consult a registered nutritionist-dietitian",
  ];
  List<String> dietary_diversity_score = [
    "Follow the Pinggang Pinoy for moderate, balanced and varied meals.",
    "Make your plate as colorful as possible for more fruits and vegetables in the diet.",
    "Opt for whole grains such as brown rice, whole wheat bread and lean/ plant-based protein sources such as fish, egg, chicken breast, and tofu.",
    "Drink 6 to 8 glasses of water on a daily basis.",
    "Consult a registered nutritionist-dietitian",
  ];
  List<String> healty_eating_index = [
    "Follow the Pinggang Pinoy for a balanced diet.",
    "Always incorporate fruits and vegetables in the diet.",
    "Focus on the overall diet, not individual foods:\nThe key to healthy eating is the total pattern of food intake, emphasizing moderation, balance and variety (MoBaVa).",
    "Avoid labeling foods as \"Good\" or \"Bad\":\nInstead of focusing on specific food as being \"healthy\" or \"unhealthy,\" aim for a realistic approach that includes all food in moderation, which reduces unhealthy eating behaviors.",
    "Consult a registered nutritionist-dietitian",
  ];
  List<String> glycemic_index = [
    "Choose low GI food such as Sweet Potato, Steel-Cut Oats, Apple, Lentils, etc for better glycemic response.",
    "Pair high-GI food with low-GI food to reduce glycemic impact such as eating white bread and peanut butter.",
    "Have whole fruits (e.g. apple, pear, banana) and vegetables as snacks than refined carbohydrates like granola bars and sugary snacks for an improved glycemic control.",
    "Control Portion Sizes to Manage Glycemic Load. Even if a food has a low glycemic index (GI), consuming it in excess can still lead to a high glycemic load (GL).",
    "Consult a registered nutritionist-dietitian",
  ];

  List<Map<dynamic, dynamic>> advices = [];
  final Map<String, String> categoryImages = {
    "Body Mass Index": 'assets/images/undraw_fitness_stats.png',
    "Physical Activity": 'assets/images/undraw_jogging.png',
    "Dietary Diversity Score": 'assets/images/undraw_diet.png',
    "Healthy Eating Index": 'assets/images/undraw_healthy_lifestyle.png',
    "Glycemic Index": 'assets/images/undraw_ice_cream.png',
    "Dietary Assessment": 'assets/images/undraw_breakfast.png'
  };

  void addUniqueAdvice(List<String> sourceList, String category) {
    Random random = Random();
    String advice;

    do {
      advice = sourceList[random.nextInt(sourceList.length)];
    } while (
        advice == "Consult a registered nutritionist-dietitian" && advices.any((item) => item['advice'] == advice));

    advices.add({'category': category, 'advice': advice});
  }

  @override
  void initState() {
    super.initState();

    if (widget.isBmiNormal!) {
      addUniqueAdvice(bmi_normal, "Body Mass Index");
    } else if (widget.isBmiObese!) {
      addUniqueAdvice(bmi_obese, "Body Mass Index");
    } else if (widget.isBmiUnderweight!) {
      addUniqueAdvice(bmi_underweight, "Body Mass Index");
    }

    if (widget.isNormalPhysicalActivity!) {
      if (!advices.any((item) => item['advice'] == normal_physical_activity)) {
        advices.add({'category': "Physical Activity", 'advice': normal_physical_activity});
      }
    } else {
      addUniqueAdvice(physical_activity, "Physical Activity");
    }

    addUniqueAdvice(dietary_assessment, "Dietary Assessment");
    addUniqueAdvice(dietary_diversity_score, "Dietary Diversity Score");
    addUniqueAdvice(healty_eating_index, "Healthy Eating Index");
    addUniqueAdvice(glycemic_index, "Glycemic Index");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "General Advices",
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 8.0),
            itemCount: advices.length,
            itemBuilder: (BuildContext context, int index) {
              final adviceItem = advices[index];
              final category = adviceItem['category'];
              final imagePath = categoryImages[category];

              return Card(
                elevation: 3.0,
                surfaceTintColor: Colors.teal[600],
                child: Column(
                  children: [
                    Image.asset(imagePath!),
                    ListTile(
                      title: Text(
                        adviceItem['category'],
                        style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                      ),
                      subtitle: Text(
                        adviceItem['advice'],
                        style: TextStyle(color: Colors.black.withOpacity(0.6), fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
