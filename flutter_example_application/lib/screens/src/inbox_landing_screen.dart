import 'package:flutter/material.dart';

class InboxLandingScreen extends StatefulWidget {
  static const routeName = '/inbox_landing_screen';
  static const sreenName = "Messages";

  const InboxLandingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _InboxLandingScreenState();
  }
}

class _InboxLandingScreenState extends State<InboxLandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(InboxLandingScreen.sreenName),
        ),
        body: Container(
          color: Colors.white,
        ));
  }
}
