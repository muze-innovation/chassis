import 'dart:async';
import 'package:flutter_chassis/models/chassis_request.dart';

mixin DataProvider {
  void getData(StreamController<dynamic> controller, ChassisRequest request);
}
