import 'package:diabuddy/screens/dashboard_screen.dart';
import 'package:diabuddy/screens/login_screen.dart';
import 'package:diabuddy/screens/notification_screen.dart';
import 'package:diabuddy/screens/notification_settings_screen.dart';
import 'package:diabuddy/screens/onboarding.dart';
import 'package:diabuddy/screens/profile_screen.dart';
import 'package:diabuddy/screens/reader.dart';
import 'package:diabuddy/screens/signup_screen.dart';
import 'package:diabuddy/widgets/bottomnavbar.dart';

import 'package:flutter/material.dart';
import 'package:gtext/gtext.dart';

void main() {
  GText.init(to: 'fi', enableCaching: false);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
        ),
      ),
      // initialRoute: "/signupScreen",
      // initialRoute: "/chooseReadOptionScreen",
      // initialRoute: "/loginScreen",
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
        return null;
      },
    );
  }
}
