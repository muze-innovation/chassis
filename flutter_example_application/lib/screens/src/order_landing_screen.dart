import 'package:flutter/material.dart';

class OrderLandingScreen extends StatelessWidget {
  static const routeName = '/order_landing_screen';
  static const sreenName = "Activities";

  const OrderLandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(OrderLandingScreen.sreenName),
        ),
        body: Container(
          color: Colors.white,
        ));
  }
}
