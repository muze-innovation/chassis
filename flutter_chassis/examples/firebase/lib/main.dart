/// Packages
import 'package:firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

/// Local Files
import 'screens/food_landing_screen.dart';
import 'screens/home_landing_screen.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
