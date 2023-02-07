import 'dart:async';

import 'package:data_provider/repository/banner_repository.dart';

import '../model/banner_output.dart';

abstract class IBannerDataProvider {
  Stream<BannerOutput> getData(String slug);
}

class BannerDataProvider implements IBannerDataProvider {
  final _bannerRepository = BannerRepository();

  @override
  Stream<BannerOutput> getData(String slug) {
    return _bannerRepository
        .getData(slug)
        .asStream()
        .map((event) => BannerOutput.fromJson(event));
  }
}
