import 'dart:async';

import 'package:chassis/chassis.dart';
import 'package:data_provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example_application/screens/screens.dart';

void main() {
  final dataProvider = DataProvider();

  final chassis = Chassis.setDataProvider(dataProvider);
  final controller = StreamController<Map<String, dynamic>>.broadcast();
  final payload = {
    "resolvedWith": "GetBanner",
    "input": {"slug": "best_seller"}
  };
  controller.stream.listen(
    (value) {
      print('StreamController get value asset: ${value["asset"]}');
    },
    onDone: () {
      print('main onDone');
    },
    onError: (e) {
      print('error is $e');
    },
    cancelOnError: false,
  );
  Chassis.getView(payload);

  chassis.getData(controller, payload);
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
