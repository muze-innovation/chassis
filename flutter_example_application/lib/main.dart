import 'dart:async';

import 'package:chassis/chassis.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_provider/data_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:view_provider/view_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example_application/screens/screens.dart';

// void main() {
//   // setup chassis
//   final dataProvider = DataProvider();
//   final viewProvider = ViewProvider();
//   Chassis.setup(dataProvider: dataProvider, viewProvider: viewProvider);

//   // run app
//   runApp(const MyApp());
// }
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // setup chassis
  final dataProvider = DataProvider();
  final viewProvider = ViewProvider();
  Chassis.setup(dataProvider: dataProvider, viewProvider: viewProvider);
  runApp(const MyApp());
  readDataFireStore();
}

class QuickAccessItem {
  final List<Item>? item;

  QuickAccessItem(this.item);
  Map<String, dynamic> toJson() => {'item': item};

  QuickAccessItem.fromJson(Map<String, dynamic> json) : item = json['name'];
}

class Item {
  final String? title;
  final String? asset;
  Item(this.title, this.asset);
  Map<String, dynamic> toJson() => {'title': title, 'asset': asset};
  Item.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        asset = json['asset'];
}

void readDataFireStore() {
  Stream documentStream = FirebaseFirestore.instance
      .collection('quickAccessItem')
      .doc('C31m6JDhRAkqItIzWsKP')
      .snapshots();
  documentStream.listen((event) {
    event as DocumentSnapshot;
    // event.data() as Map<String, dynamic>;
    print("documentStream: ${event.data() as Map<String, dynamic>}");
  });
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
