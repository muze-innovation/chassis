import 'dart:async';

import 'package:data_provider/repository/banner_repository.dart';

abstract class IBannerDataProvider {
  void getData(StreamController<dynamic> controller, String slug) async {}
}

class BannerDataProvider implements IBannerDataProvider {
  final _bannerRepository = BannerRepository();
  @override
  void getData(StreamController<dynamic> controller, String slug) async {
    await _bannerRepository.getData(slug).then((Map<String, dynamic> value) {
      controller.add(value);
    }, onError: (e) {
      controller.addError(e);
    });
  }
}
