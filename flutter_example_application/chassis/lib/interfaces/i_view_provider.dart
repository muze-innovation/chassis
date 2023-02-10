import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:chassis/models/chassis_item.dart';

mixin IViewProvider {
  Widget? getView(Stream<dynamic> stream, ChassisItem item);
}
