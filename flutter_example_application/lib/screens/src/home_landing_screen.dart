import 'package:flutter/material.dart';
import 'package:flutter_example_application/screens/src/food_landing_screen.dart';

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
            child: const Text(FoodLandingScreen.sreenName),
            onPressed: () {
              Navigator.pushNamed(context, FoodLandingScreen.routeName);
            },
          ),
        ));
  }
}
