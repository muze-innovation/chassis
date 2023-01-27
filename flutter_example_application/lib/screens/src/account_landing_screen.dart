import 'package:flutter/material.dart';

class AccountLandingScreen extends StatefulWidget {
  static const routeName = ' /account_landing_screen';
  static const sreenName = "Account";

  const AccountLandingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AccountLandingScreenState();
  }
}

class _AccountLandingScreenState extends State<AccountLandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(AccountLandingScreen.sreenName),
        ),
        body: Container(
          color: Colors.white,
        ));
  }
}
