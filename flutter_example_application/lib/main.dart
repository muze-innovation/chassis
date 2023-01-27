import 'package:flutter/material.dart';
import 'package:flutter_example_application/screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: MainScreen.routeName,
      routes: {
        MainScreen.routeName: (context) => const MainScreen(),
        HomeLandingScreen.routeName: (context) => const HomeLandingScreen(),
        FoodLandingScreen.routeName: (context) => const FoodLandingScreen(),
        AccountLandingScreen.routeName: (context) =>
            const AccountLandingScreen(),
      },
    );
  }
}
