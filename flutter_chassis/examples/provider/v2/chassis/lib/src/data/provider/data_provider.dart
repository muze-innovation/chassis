import 'dart:async';

import '../../model/request/request.dart';

/// A base class for data provider.
/// Version 2.0
abstract class DataProviderBase {
  Map<String, DataProviderBase> routeTable = {};

  void getData(
      StreamController<Map<String, dynamic>> controller, Request request);
}
