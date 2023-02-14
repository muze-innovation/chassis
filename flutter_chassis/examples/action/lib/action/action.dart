import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

mixin ActionDelegate {
  Future<bool> onAction(BuildContext context, Map<String, dynamic> config,
      Map<String, dynamic>? data);
}

class ActionUrl {
  static String get back => '/..';
  static String get backToHome => '/~';
}

class ActionManager {
  String type = '';
  String url = '';
  static final Future<bool> _successFuture = Future(() => true);

  ActionManager({required this.type, required this.url});

  ActionManager.fromJson(Map<String, dynamic>? json) {
    type = json?["type"] ?? '';
    url = json?["url"] ?? '';
  }

  Future<bool> execute(
          BuildContext context, Map<String, dynamic>? data) async =>
      _execute(context, data);

  Future<bool> _execute(BuildContext context, Map<String, dynamic>? data) {
    switch (type) {
      case 'navigate':
        return _navigate(context);
      case 'route':
        return _goToRoute(context, data);
      default:
        throw Exception('Action not supported');
    }
  }

  // Handle navigating to outside websites
  Future<bool> _navigate(BuildContext context) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  // Handle routing to another page
  Future<bool> _goToRoute(
      BuildContext context, Map<String, dynamic>? data) async {
    if (url == ActionUrl.back) {
      Navigator.pop(context);
    } else if (url == ActionUrl.backToHome) {
      Navigator.popUntil(context, (route) => route.isFirst);
      // Navigator.pushReplacementNamed(context, '/main_screen');
    } else {
      Navigator.pushNamed(context, url, arguments: data);
    }

    return _successFuture;
  }
}
