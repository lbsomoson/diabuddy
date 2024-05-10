import 'package:diabuddy/screens/dashboard_screen.dart';
import 'package:diabuddy/screens/history.dart';
import 'package:diabuddy/screens/history_all.dart';
import 'package:diabuddy/screens/login_screen.dart';
import 'package:diabuddy/screens/meal_details.dart';
import 'package:diabuddy/screens/meal_tracker.dart';
import 'package:diabuddy/screens/notification_screen.dart';
import 'package:diabuddy/screens/notification_settings_screen.dart';
import 'package:diabuddy/screens/onboarding.dart';
import 'package:diabuddy/screens/profile_screen.dart';
import 'package:diabuddy/screens/reader.dart';
import 'package:diabuddy/screens/signup_screen.dart';
import 'package:diabuddy/widgets/bottomnavbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:flutter/material.dart';
import 'package:gtext/gtext.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  GText.init(to: 'fi', enableCaching: false);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: Color.fromRGBO(100, 204, 197, 1),
          secondary: Color.fromRGBO(4, 54, 74, 1),
        ),
        textTheme: TextTheme(
          // Screen Title
          bodyLarge: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color.fromRGBO(4, 54, 74, 1),
            fontFamily: 'Roboto',
          ),
          // Text Label for Buttons
          bodyMedium: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Roboto',
          ),
          bodySmall: TextStyle(
            color: Colors.grey[500],
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
          // Button
          labelLarge: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600,
            fontFamily: 'Roboto',
          ),
          // Text Field Helper
          labelMedium: TextStyle(
            color: Colors.grey[500],
            fontSize: 15,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
          titleSmall: TextStyle(
            fontSize: 15,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w400,
            color: Colors.grey[500],
          ),
          titleMedium: const TextStyle(
            fontSize: 18,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w400,
            color: Color.fromRGBO(100, 204, 197, 1),
          ),
        ),
      ),
      // initialRoute: "/signupScreen",
      // initialRoute: "/chooseReadOptionScreen",
      // initialRoute: "/loginScreen",
      // initialRoute: "/onboarding",
      onGenerateRoute: (settings) {
        if (settings.name == "/") {
          return MaterialPageRoute(builder: (context) => const BottomNavBar());
        }
        if (settings.name == "/signupScreen") {
          return MaterialPageRoute(builder: (context) => const SignUpScreen());
        }
        if (settings.name == "/loginScreen") {
          return MaterialPageRoute(builder: (context) => const LoginScreen());
        }
        if (settings.name == "/onboarding") {
          return MaterialPageRoute(
              builder: (context) => const OnboardingScreen());
        }
        if (settings.name == "/dashboardScreen") {
          return MaterialPageRoute(
              builder: (context) => const DashboardScreen());
        }
        if (settings.name == "/profileScreen") {
          return MaterialPageRoute(builder: (context) => const ProfileScreen());
        }
        if (settings.name == "/notificationScreen") {
          return MaterialPageRoute(
              builder: (context) => const NotificationScreen());
        }
        if (settings.name == "/notificationSettingsScreen") {
          return MaterialPageRoute(
              builder: (context) => const NotificationSettingsScreen());
        }
        if (settings.name == "/chooseReadOptionScreen") {
          return MaterialPageRoute(
              builder: (context) => const ChooseReadOptionScreen());
        }
        if (settings.name == "/history") {
          return MaterialPageRoute(builder: (context) => const HistoryScreen());
        }
        if (settings.name == "/historyAll") {
          return MaterialPageRoute(
              builder: (context) => const HistoryAllScreen());
        }
        if (settings.name == "/mealTrackerScreen") {
          return MaterialPageRoute(
              builder: (context) => const MealTrackerScreen());
        }
        if (settings.name == "/mealDetailsScreen") {
          return MaterialPageRoute(
              builder: (context) => const MealDetailsScreen());

          // final name = settings.arguments as String;
          // final carbs = settings.arguments as String;
          // final cal = settings.arguments as String;
          // final gi = settings.arguments as String;
          // final date = settings.arguments as String;
          // return MaterialPageRoute(
          //     builder: (context) => MealDetailsScreen(
          //           name: name,
          //           carbs: carbs,
          //           cal: cal,
          //           gi: gi,
          //           date: date,
          //         ));
        }
        return null;
      },
    );
  }
}
