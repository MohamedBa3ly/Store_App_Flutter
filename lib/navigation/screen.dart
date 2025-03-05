// Screens in App:
import 'package:flutter/material.dart';

class InitialScreens {
  static const String details = "details_screen";
  static const String add = "add_screen";
  static const String update = "update_screen";
}


class BottomNavigationScreen {
  final String route;
  final String title;
  final IconData icon;

  const BottomNavigationScreen({
    required this.route,
    required this.title,
    required this.icon,
  });

  // Bottom Navigation Screens
  static const BottomNavigationScreen home = BottomNavigationScreen(
    route: "home",
    title: "Home",
    icon: Icons.home_outlined,
  );

  static const BottomNavigationScreen information = BottomNavigationScreen(
    route: "favourites",
    title: "Info",
    icon: Icons.home_outlined,
  );


  static const BottomNavigationScreen cart = BottomNavigationScreen(
    route: "cart",
    title: "Cart",
    icon: Icons.home_outlined,
  );

  static const BottomNavigationScreen settings = BottomNavigationScreen(
    route: "settings",
    title: "Settings",
    icon: Icons.home_outlined,
  );

}

// Items in Bottom Navigation:
final List<BottomNavigationScreen> bottomNavigationItems = [
  BottomNavigationScreen.home,
  BottomNavigationScreen.information,
  BottomNavigationScreen.cart,
  BottomNavigationScreen.settings
];