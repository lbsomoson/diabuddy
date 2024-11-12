import 'package:diabuddy/provider/auth_provider.dart';
import 'package:diabuddy/screens/dashboard_screen.dart';
import 'package:diabuddy/screens/login_screen.dart';
import 'package:diabuddy/screens/meal_tracker.dart';
import 'package:diabuddy/screens/profile_screen.dart';
import 'package:diabuddy/utils/local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final controller = PersistentTabController(initialIndex: 0);

  @override
  void initState() {
    super.initState();
    LocalNotifications.initialize();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List<PersistentTabConfig> _tabs() => [
        PersistentTabConfig(
          screen: const DashboardScreen(),
          item: ItemConfig(
            icon: const Icon(Icons.home),
            // title: "Home",
            inactiveForegroundColor: Colors.grey[400]!,
            activeForegroundColor: Theme.of(context).colorScheme.primary,
          ),
        ),
        PersistentTabConfig(
          screen: const MealTrackerScreen(),
          item: ItemConfig(
            icon: const Icon(FontAwesomeIcons.bowlFood),
            // title: "Daily Meal",
            inactiveForegroundColor: Colors.grey[400]!,
            activeForegroundColor: Theme.of(context).colorScheme.primary,
          ),
        ),
        // PersistentTabConfig(
        //   screen: const CameraScreen(),
        //   item: ItemConfig(
        //     icon: const Icon(FontAwesomeIcons.camera, color: Colors.white),
        //     // title: "Record",
        //     inactiveForegroundColor: Colors.grey[400]!,
        //     activeForegroundColor: Theme.of(context).colorScheme.primary,
        //   ),
        // ),
        // PersistentTabConfig(
        //   screen: const NotificationScreen(),
        //   item: ItemConfig(
        //     icon: const Icon(Icons.notifications),
        //     // title: "Notifications",
        //     inactiveForegroundColor: Colors.grey[400]!,
        //     activeForegroundColor: Theme.of(context).colorScheme.primary,
        //   ),
        // ),
        PersistentTabConfig(
          screen: const ProfileScreen(),
          item: ItemConfig(
            icon: const Icon(Icons.person),
            // title: "Profile",
            inactiveForegroundColor: Colors.grey[400]!,
            activeForegroundColor: Theme.of(context).colorScheme.primary,
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final isSignedIn = context.watch<UserAuthProvider>().user;

    if (isSignedIn == null) {
      return const LoginScreen();
    }

    return PersistentTabView(
      controller: controller,
      tabs: _tabs(),
      navBarBuilder: (navBarConfig) => Style4BottomNavBar(
        navBarConfig: navBarConfig,
      ),
    );
  }
}
