/// Support for doing something awesome.
///
/// More dartdocs go here.
library data_provider;

import 'dart:async';

import 'package:chassis/chassis.dart';
import 'src/banner_data_provider.dart';
import 'src/constant.dart';

export 'src/data_provider_base.dart';

class DataProvider implements IDataProvider {
  final _bannerDataProvider = BannerDataProvider();
  @override
  void getData(StreamController controller, Map<String, dynamic> payload) {
    payload[resolvedWith];
    switch (payload[resolvedWith]) {
      case getBanner:
        _bannerDataProvider.getData(controller);
        break;
      default:
    }
  }
}
