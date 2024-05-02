import 'package:diabuddy/screens/dashboard_screen.dart';
import 'package:diabuddy/screens/loginScreen.dart';
import 'package:diabuddy/screens/notificationScreen.dart';
import 'package:diabuddy/screens/notificationSettingsScreen.dart';
import 'package:diabuddy/screens/profileScreen.dart';
import 'package:diabuddy/screens/signupScreen.dart';
import 'package:diabuddy/widgets/bottomnavbar.dart';
import 'package:flutter/services.dart';
// import 'package:diabuddy/widgets/bottomnavbar.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import 'package:flutter/material.dart';
import 'package:gtext/gtext.dart';

void main() {
  GText.init(to: 'fi', enableCaching: false);
  WidgetsFlutterBinding.ensureInitialized();
  // make navigation bar transparent
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  // make flutter draw behind navigation bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
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
          titleSmall: const TextStyle(
              // fontSize: 14,
              // fontStyle: FontStyle.italic,
              // fontWeight: FontWeight.w400,
              // color: Color.fromARGB(255, 255, 231, 161),
              ),
        ),
      ),
      // initialRoute: "/signupScreen",
      // initialRoute: "/loginScreen",
      onGenerateRoute: (settings) {
        if (settings.name == "/") {
          return MaterialPageRoute(builder: (context) => const BottomNavBar());
        }
        if (settings.name == "/notificationScreen") {
          return MaterialPageRoute(
              builder: (context) => const NotificationScreen());
        }
        if (settings.name == "/signupScreen") {
          return MaterialPageRoute(builder: (context) => const SignUpScreen());
        }
        if (settings.name == "/loginScreen") {
          return MaterialPageRoute(builder: (context) => const LoginScreen());
        }
        if (settings.name == "/dashboardScreen") {
          return MaterialPageRoute(
              builder: (context) => const DashboardScreen());
        }
        if (settings.name == "/profileScreen") {
          return MaterialPageRoute(builder: (context) => const ProfileScreen());
        }
        if (settings.name == "/notificationSettingsScreen") {
          return MaterialPageRoute(
              builder: (context) => const NotificationSettingsScreen());
        }
        return null;
      },
    );
  }
}
