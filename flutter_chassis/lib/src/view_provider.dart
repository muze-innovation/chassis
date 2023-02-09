import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_chassis/models/chassis_item.dart';

mixin ViewProvider {
  Widget getView(Stream<dynamic> stream, ChassisItem item);
}
