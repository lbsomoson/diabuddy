// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'dart:math';

class AdviceScreen extends StatefulWidget {
  final String bmi, physicalActivity;
  const AdviceScreen({required this.bmi, required this.physicalActivity, super.key});

  @override
  State<AdviceScreen> createState() => _AdviceScreenState();
}

class _AdviceScreenState extends State<AdviceScreen> {
  List<String> bmi_underweight = [
    '''Follow a healthy eating plan through the Pinggang Pinoy by:
    - Emphasize vegetables, fruits, whole grains, and fat-free or low-fat dairy products, including lean meats, poultry, fish, beans, eggs, and nuts.
    - Lessen saturated and trans fats, sodium, and added sugars.
    Apply Portion Size.''',
    'Gradually increase your weight by adding healthy calories of 300 to 600 per day.\n***Avoid empty calories such as sugar sweetened beverages, cakes, donuts, etc. as they may lead to excess fat.',
    'Add extra ingredients to your meals for extra calories such as cheese, nuts, avocado, and dry or liquid milk.',
    'Eat the right amount of protein to support your needs.',
    'Healthy adult with minimal physical activity, 0.8 kilogram per body weight.',
    'For those who regularly exercise and lift weights, aim for 1.2 - 1.7 g of protein per kilogram bodyweight to maximize muscle protein accretion.',
    'Drink your beverages after meals as drinking during or before the meals may help you feel full easily.',
    'Stay hydrated with 6 to 8 glasses of water and lessen sugar-sweetened beverages.',
    'Write down what you eat using a Food Diary to help you identify which food must be consumed more or less.\nE.g. type of food consumed, quantity and meal time',
    'Set specific goals to stay on track of your food and fitness regimen.\nI will improve my health by following the Pinggang Pinoy guidelines for every meal and exercising for 1 hour, 3 times per week, for the next 12 weeks. I will ensure I include a balanced portion of vegetables, protein, and grains in each meal according to the Pinggang Pinoy standards. I will track my food intake using a food diary app and my workouts using a fitness tracker to monitor my progress and make adjustments as needed.',
    'Aim for at least 20 minutes of cardio exercise three times a week. In addition, incorporate strength or weight training twice a week to help build and maintain lean muscle mass, which supports healthy weight gain.',
    'Move more and sit less throughout the day for optimal health. For every half hour, walk for 5 minutes.',
    'Consult a registered nutritionist-dietitian.'
  ];
  List<String> bmi_normal = [
    '''Follow a healthy eating plan through the Pinggang Pinoy by:
    - Emphasize vegetables, fruits, whole grains, and fat-free or low-fat dairy products, including lean meats, poultry, fish, beans, eggs, and nuts. 
    - Lessen saturated and trans fats, sodium, and added sugars. Apply Portion Size''',
    'Balance the calories that you eat and calories that you burn from physical activity for weight maintenance.\n***Avoid empty calories such as sugar sweetened beverages, cakes, donuts, etc. as they may lead to excess fat.',
    'Swap your usual food for healthier alternatives such as fresh fruits over biscuits with added sugar.',
    'Eat the right amount of protein to support your needs.\nHealthy adult with minimal physical activity, 0.8 kilogram per body weight.\nFor those who regularly exercise and lift weights, aim for 1.2 - 1.7 g of protein per kilogram bodyweight to maximize muscle protein accretion.',
    'Stay hydrated with 6 to 8 glasses of water and lessen sugar-sweetened beverages.',
    'Write down what you eat using a Food Diary to help you identify which food must be consumed more or less.\nE.g. type of food consumed, quantity and meal time',
    'Set specific goals to stay on track of your food and fitness regimen.\nI will improve my health by following the Pinggang Pinoy guidelines for every meal and exercising for 1 hour, 3 times per week, for the next 12 weeks. I will ensure I include a balanced portion of vegetables, protein, and grains in each meal according to the Pinggang Pinoy standards. I will track my food intake using a food diary app and my workouts using a fitness tracker to monitor my progress and make adjustments as needed.',
    'Regularly exercise to maintain a healthy weight.\nAim at least 150 minutes to 300 minutes of moderate-intensity per week. Also, include muscle-strengthening activities 2 or more days a week for additional health benefits.',
    'Move more and sit less throughout the day for optimal health. For every half hour, walk for 5 minutes.',
    "Consult a registered nutritionist-dietitian",
  ];
  List<String> bmi_overweight = [
    '''Follow a healthy eating plan through the Pinggang Pinoy by:
    - Emphasize vegetables, fruits, whole grains, and fat-free or low-fat dairy products, including lean meats, poultry, fish, beans, eggs, and nuts. 
    - Lessen saturated and trans fats, sodium, and added sugars. Apply Portion Size''',
    'Gradually decrease your weight by decreasing your calories from 500 to 1000 calories per day.\n***Avoid empty calories such as sugar sweetened beverages, cakes, donuts, etc. as they may lead to excess fat.',
    'Swap your usual food for healthier alternatives such as fresh fruits over biscuits with added sugar.',
    'Eat the right amount of protein to support your needs.\nHealthy adult with minimal physical activity, 0.8 kilogram per body weight.\nFor those who regularly exercise and lift weights, aim for 1.2 - 1.7 g of protein per kilogram bodyweight to maximize muscle protein accretion.',
    'Drink water before meals to lessen food intake.',
    'Stay hydrated with 6 to 8 glasses of water and lessen sugar-sweetened beverages.',
    'Write down what you eat using a Food Diary to help you identify which food must be consumed more or less.\nE.g. type of food consumed, quantity and meal time',
    'Set specific goals to stay on track of your food and fitness regimen.\nI will improve my health by following the Pinggang Pinoy guidelines for every meal and exercising for 1 hour, 3 times per week, for the next 12 weeks. I will ensure I include a balanced portion of vegetables, protein, and grains in each meal according to the Pinggang Pinoy standards. I will track my food intake using a food diary app and my workouts using a fitness tracker to monitor my progress and make adjustments as needed.',
    'Regularly exercise to maintain a healthy weight.\nAim at least 300 minutes of moderate-intensity or 150 minutes of vigorous activity per week. Also, include muscle-strengthening activities 2 or more days a week for additional health benefits.',
    'Move more and sit less throughout the day for optimal health. For every half hour, walk for 5 minutes.',
    "Consult a registered nutritionist-dietitian",
  ];
  List<String> bmi_obese = [
    '''Follow a healthy eating plan through the Pinggang Pinoy by:
    - Emphasize vegetables, fruits, whole grains, and fat-free or low-fat dairy products, including lean meats, poultry, fish, beans, eggs, and nuts. 
    - Lessen saturated and trans fats, sodium, and added sugars. Apply Portion Size''',
    'Gradually decrease your weight by decreasing your calories from 500 to 1000 calories per day.\n***Avoid empty calories such as sugar sweetened beverages, cakes, donuts, etc. as they may lead to excess fat.',
    'Swap your usual food for healthier alternatives such as fresh fruits over biscuits with added sugar.',
    'Eat the right amount of protein to support your needs.\nHealthy adult with minimal physical activity, 0.8 kilogram per body weight.\nFor those who regularly exercise and lift weights, aim for 1.2 - 1.7 g of protein per kilogram bodyweight to maximize muscle protein accretion.',
    'Drink water before meals to lessen food intake.',
    'Stay hydrated with 6 to 8 glasses of water and lessen sugar-sweetened beverages.',
    'Write down what you eat using a Food Diary to help you identify which food must be consumed more or less.\nE.g. type of food consumed, quantity and meal time',
    'Set specific goals to stay on track of your food and fitness regimen.\nI will improve my health by following the Pinggang Pinoy guidelines for every meal and exercising for 1 hour, 3 times per week, for the next 12 weeks. I will ensure I include a balanced portion of vegetables, protein, and grains in each meal according to the Pinggang Pinoy standards. I will track my food intake using a food diary app and my workouts using a fitness tracker to monitor my progress and make adjustments as needed.',
    'Regularly exercise to maintain a healthy weight.\nAim at least 300 minutes of moderate-intensity or 150 minutes of vigorous activity per week. Also, include muscle-strengthening activities 2 or more days a week for additional health benefits.',
    'Move more and sit less throughout the day for optimal health. For every half hour, walk for 5 minutes.',
    "Consult a registered nutritionist-dietitian",
  ];
  List<String> sedentary = [
    'Small habits make a difference — the key is consistency. Begin with 10 to 15 minutes of exercise per day. Gradually increase your workout duration by five minutes every two to four weeks, or as you feel ready.',
    'When parking your car, park farther from the entrance to intentionally walk extra steps. For commuters, get off the bus early and walk the rest of the way.',
    'Move more and sit less by walking for 5 minutes every 30 minutes.',
    'Stretch every day for flexibility and to prepare yourself for workouts in the future.',
    'Invite family and friends to join you—working out together is more enjoyable and helps you stay consistent.\nDogs can also make great walking companions.',
    'Instead of calling or emailing a colleague, walk to their workstation to communicate.',
    'Always stand or walk around when you\'re on the phone.',
    'Have a fitness tracker to keep you engaged on your fitness regimen. Log the date, type of activity and duration.',
    'Instead of taking the elevator or escalator, use the stairs instead.',
    'Do household chores such as vacuuming and mopping the floor, washing the car or light gardening.',
    'Consult a registered nutritionist-dietitian, physical therapist or doctor.',
  ];
  List<String> light = [
    'Small habits make a difference — the key is consistency. Begin with 10 to 15 minutes of exercise per day. Gradually increase your workout duration by five minutes every two to four weeks, or as you feel ready.',
    'When parking your car, park farther from the entrance to intentionally walk extra steps. For commuters, get off the bus early and walk the rest of the way.',
    'Move more and sit less by walking for 5 minutes every 30 minutes.',
    'Stretch every day for flexibility and to prepare yourself for workouts in the future.',
    'Invite family and friends to join you—working out together is more enjoyable and helps you stay consistent.\nDogs can also make great walking companions.',
    'Instead of calling or emailing a colleague, walk to their workstation to communicate.',
    'Always stand or walk around when you\'re on the phone.',
    'Have a fitness tracker to keep you engaged on your fitness regimen. Log the date, type of activity and duration.',
    'Instead of taking the elevator or escalator, use the stairs instead.',
    'Do household chores such as vacuuming and mopping the floor, washing the car or light gardening.',
    'Consult a registered nutritionist-dietitian, physical therapist or doctor.',
  ];
  List<String> active = [
    'Aim for 150 minutes of moderate-intensity exercise or 75 minutes of vigorous activity each week. Incorporate muscle-strengthening exercises, like weightlifting or resistance training, at least twice a week.',
    '''Follow a varied physical routine for overall fitness health:
    - Cardiovascular Endurance: Cardio exercises such as walking, jogging, swimming, riding a bike, dancing, etc.
    - Muscular Strength: Lifting weights, using resistance bands, climbing stairs, heavy gardening, etc.
    - Bone Strength: Weight-bearing exercise such as brisk walking, jogging, badminton, climbing stairs, etc.;
      - Resistance training such as lifting weights and body exercises such as push ups or pull ups; and balance training.
    - Balance: Weight shift, tai chi, etc.
    - Flexibility: Stretching, yoga, pilates, etc.''',
    'Brisk walking (at least 2.5 mph)\nWater Aerobics Dancing\nGardening\nDoubles Tennis\nBiking (under 10 mph)\nYoga\nWeight training\nHousework that involves intense scrubbing and cleaning',
    'Move more and sit less by walking for 5 minutes every 30 minutes.',
    'Invite family and friends to join you—working out together is more enjoyable and helps you stay consistent. Dogs can also make great walking companions.',
    'Have a fitness tracker to keep you engaged on your fitness regimen. Log the date, type of activity and duration.',
    'Consult a registered nutritionist-dietitian, physical therapist or doctor.',
  ];
  List<String> strenous = [
    'Aim for 150 minutes of moderate-intensity exercise or 75 minutes of vigorous activity each week. Incorporate muscle-strengthening exercises, like weightlifting or resistance training, at least twice a week.',
    '''Follow a varied physical routine for overall fitness health:
    - Cardiovascular Endurance: Cardio exercises such as walking, jogging, swimming, riding a bike, dancing, etc.
    - Muscular Strength: Lifting weights, using resistance bands, climbing stairs, heavy gardening, etc.
    - Bone Strength: Weight-bearing exercise such as brisk walking, jogging, badminton, climbing stairs, etc.;
      - Resistance training such as lifting weights and body exercises such as push ups or pull ups; and balance training.
    - Balance: Weight shift, tai chi, etc.
    - Flexibility: Stretching, yoga, pilates, etc.''',
    'Hiking uphill or with a heavy backpack\nRunning\nSwimming laps\nVigorous aerobic dancing\nIntense yard work like digging or hoeing\nSingles tennis\nKarate, judo, tae kwon do, jujitsu\nCompetitive Basketball, Soccer or Football\nCycling at 10 mph or faster\nJumping rope',
    'Move more and sit less by walking for 5 minutes every 30 minutes.',
    'Invite family and friends to join you—working out together is more enjoyable and helps you stay consistent. Dogs can also make great walking companions.',
    'Have a fitness tracker to keep you engaged on your fitness regimen. Log the date, type of activity and duration.',
    'Consult a registered nutritionist-dietitian, physical therapist or doctor.',
  ];
  List<String> dietary_assessment = [
    "Follow the Pinggang Pinoy by:\nFilling half of your plate with fruits and vegetables, ⅔ for grains, bread, pasta, etc. and ⅓ for protein.",
    '''Make healthier food choices when dining out by:
    - Whole-grain options like whole wheat bread or brown rice
    - Meals with fruits and vegetables
    - Lean proteins like grilled chicken or baked fish
    - Lessen the use of condiments
    - Cook at home to improve health as home-cooked meals typically include more fruits, vegetables, and fiber, while reducing your intake of salt and saturated fat.''',
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

    if (widget.bmi == 'normal') {
      addUniqueAdvice(bmi_normal, "Body Mass Index");
    } else if (widget.bmi == 'obese') {
      addUniqueAdvice(bmi_obese, "Body Mass Index");
    } else if (widget.bmi == 'underweight') {
      addUniqueAdvice(bmi_underweight, "Body Mass Index");
    } else if (widget.bmi == 'overweight') {
      addUniqueAdvice(bmi_overweight, "Body Mass Index");
    }

    if (widget.physicalActivity == "sedentary") {
      addUniqueAdvice(sedentary, "Physical Activity");
    } else if (widget.physicalActivity == "light") {
      addUniqueAdvice(light, "Physical Activity");
    } else if (widget.physicalActivity == "active") {
      addUniqueAdvice(active, "Physical Activity");
    } else if (widget.physicalActivity == "strenous") {
      addUniqueAdvice(strenous, "Physical Activity");
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
