import 'package:flutter/material.dart';

mixin IAction {
  void onAction(BuildContext context, Map<String, dynamic> config, Map<String, dynamic>? data);
}