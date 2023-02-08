import 'dart:async';
import 'package:chassis/main/chassis_base.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example_application/screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // run app
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
        AccountLandingScreen.routeName: (context) => const AccountLandingScreen(),
        InboxLandingScreen.routeName: (context) => const InboxLandingScreen(),
      },
    );
  }
}
