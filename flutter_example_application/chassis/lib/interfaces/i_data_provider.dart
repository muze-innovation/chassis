import 'dart:async';
import 'package:chassis/models/chassis_request.dart';

mixin IDataProvider {
  void getData(StreamController<dynamic> controller, ChassisRequest resolver);
}
