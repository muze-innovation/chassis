import 'package:flutter/material.dart';

mixin IAction {
  void onAction(BuildContext context, Map<String, dynamic> config,
      Map<String, dynamic>? data);
}

abstract class BaseAction {
  String type;
  BaseAction(this.type);
}

class RouteAction implements BaseAction {
  @override
  String type;

  String url;

  RouteAction({required this.type, required this.url}) : super();
}
