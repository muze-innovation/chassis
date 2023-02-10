import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

mixin ActionType {
  String type = '';
}

class RouteAction with ActionType {
  final String url;
  RouteAction(this.url);
}

class ActionUrl {
  static String get back => '/..';
  static String get backToHome => '/~';
}

class ActionManager {
  String type = '';
  String url = '';

  ActionManager({required this.type, required this.url});

  ActionManager.fromJson(Map<String, dynamic>? json) {
    type = json?["type"] ?? '';
    url = json?["url"] ?? '';
  }

  void execute(BuildContext context, Map<String, dynamic>? data) async =>
      _execute(context, data);

  void _execute(BuildContext context, Map<String, dynamic>? data) {
    switch (type) {
      case 'navigate':
        return _navigate(context);
      case 'route':
        return _goToRoute(context, data);
      default:
        throw Exception('Action not supported');
    }
  }

  void _navigate(BuildContext context) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  void _goToRoute(BuildContext context, Map<String, dynamic>? data) async {
    if (url == ActionUrl.back) {
      Navigator.pop(context);
    } else if (url == ActionUrl.backToHome) {
      Navigator.popUntil(context, (route) => route.isFirst);
      // Navigator.pushReplacementNamed(context, '/main_screen');
    } else {
      Navigator.pushNamed(context, url, arguments: data);
    }
  }
}
