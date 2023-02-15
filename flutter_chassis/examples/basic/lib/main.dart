/// Packages
import 'package:flutter/material.dart';

/// Local Files
import 'screens/food_landing_screen.dart';
import 'screens/home_landing_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeLandingScreen.routeName,
      routes: {
        HomeLandingScreen.routeName: (context) => const HomeLandingScreen(),
        FoodLandingScreen.routeName: (context) => const FoodLandingScreen(),
      },
    );
  }
}
