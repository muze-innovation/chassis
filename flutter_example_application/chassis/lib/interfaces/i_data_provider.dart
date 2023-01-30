import 'dart:async';

abstract class IDataProvider {
  void getData(
      StreamController<dynamic> controller, Map<String, dynamic> payload);
}
