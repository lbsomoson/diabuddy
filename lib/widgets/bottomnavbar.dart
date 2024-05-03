import 'package:diabuddy/screens/dashboard_screen.dart';
import 'package:diabuddy/screens/notification_screen.dart';
import 'package:diabuddy/screens/notification_settings_screen.dart';
import 'package:diabuddy/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final controller = PersistentTabController(initialIndex: 0);

  List<PersistentTabConfig> _tabs() => [
        PersistentTabConfig(
          screen: const DashboardScreen(),
          item: ItemConfig(
              icon: const Icon(Icons.home),
              title: "Home",
              inactiveForegroundColor: Colors.grey[400]!,
              activeForegroundColor: Theme.of(context).colorScheme.primary),
        ),
        PersistentTabConfig(
          screen: const NotificationSettingsScreen(),
          item: ItemConfig(
              icon: const Icon(Icons.message),
              title: "Activity",
              inactiveForegroundColor: Colors.grey[400]!,
              activeForegroundColor: Theme.of(context).colorScheme.primary),
        ),
        PersistentTabConfig(
          screen: const DashboardScreen(),
          item: ItemConfig(
              icon: const Icon(
                Icons.camera,
                color: Colors.white,
              ),
              title: "Camera",
              inactiveForegroundColor: Colors.grey[400]!,
              activeForegroundColor: Theme.of(context).colorScheme.primary),
        ),
        PersistentTabConfig(
          screen: const NotificationScreen(),
          item: ItemConfig(
              icon: const Icon(Icons.notifications),
              title: "Notifications",
              inactiveForegroundColor: Colors.grey[400]!,
              activeForegroundColor: Theme.of(context).colorScheme.primary),
        ),
        PersistentTabConfig(
          screen: const ProfileScreen(),
          item: ItemConfig(
              icon: const Icon(Icons.person),
              title: "Profile",
              inactiveForegroundColor: Colors.grey[400]!,
              activeForegroundColor: Theme.of(context).colorScheme.primary),
        ),
      ];

  @override
  Widget build(BuildContext context) => PersistentTabView(
        tabs: _tabs(),
        controller: controller,
        navBarBuilder: (navBarConfig) => Style13BottomNavBar(
          navBarConfig: navBarConfig,
        ),
      );
}
