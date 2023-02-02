import 'dart:developer';

import 'package:chassis/interface.dart';
import 'package:flutter/widgets.dart';
import 'package:view_provider/example/Banner/bannerModel.dart';
import 'package:view_provider/example/Banner/bannerView.dart';
import 'package:view_provider/example/QuickAccess/quickAccessModel.dart';
import 'package:view_provider/example/QuickAccess/quickAccessView.dart';

enum ViewType { Banner, QuickAccess }

class ViewProvider implements IViewProvider {
  @override
  Widget? getView(Stream<dynamic> stream, Map<String, dynamic> config) {
    ViewType viewType = getViewType(config['viewType']);
    switch (viewType) {
      case ViewType.Banner:
        return getBannerView(stream, config);
      case ViewType.QuickAccess:
        return getQuickAccessView(stream, config);
      default:
        return null;
    }
  }

  ViewType getViewType(String value) {
    return ViewType.values.byName(value);
  }

  Widget? getBannerView(Stream<dynamic> stream, Map<String, dynamic> config) {
    BannerModel model = BannerModel.fromJson(config);
    return BannerView(stream: stream, model: model);
  }

  Widget? getQuickAccessView(
      Stream<dynamic> stream, Map<String, dynamic> config) {
    QuickAccessModel model = QuickAccessModel.fromJson(config);
    return QuickAccessView(stream: stream, model: model);
  }
}
