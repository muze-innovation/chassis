/// Packages
import 'package:flutter/material.dart';

/// Local Files
import 'food_landing_screen.dart';

class HomeLandingScreen extends StatelessWidget {
  static const routeName = '/home_landing_screen';
  static const sreenName = "Home";

  const HomeLandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(HomeLandingScreen.sreenName),
        ),
        body: Center(
          child: ElevatedButton(
            child: const Text(FoodLandingScreen.screenName),
            onPressed: () {
              Navigator.pushNamed(context, FoodLandingScreen.routeName);
            },
          ),
        ));
  }
}
