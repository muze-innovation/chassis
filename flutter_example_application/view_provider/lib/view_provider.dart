import 'dart:async';
import 'package:chassis/interface.dart';
import 'package:flutter/widgets.dart';
import 'package:view_provider/example/Banner/bannerModel.dart';
import 'package:view_provider/example/Banner/bannerView.dart';
import 'package:view_provider/example/QuickAccess/quickAccessModel.dart';
import 'package:view_provider/example/QuickAccess/quickAccessView.dart';

enum ViewType { Banner, QuickAccess }

abstract class ViewProvider implements IViewProvider {
  @override
  Widget? getView(Stream<dynamic> stream, Map<String, dynamic> config) {
    ViewType viewType = getViewType(config['viewType']);
    switch (viewType) {
      case ViewType.Banner:
        return getBannerView(stream, BannerModel.fromJson(config));
      case ViewType.QuickAccess:
        return getQuickAccessView(stream, config);
      default:
        return null;
    }
  }

  ViewType getViewType(String value) {
    return ViewType.values.byName(value);
  }

  Widget? getBannerView(Stream<dynamic> stream, BannerModel model) {
    // BannerModel model = BannerModel.fromJson(config);
    var broadcastStream =
        stream.map<BannerItem>((data) => BannerItem.fromJson(data));
    return BannerView(stream: broadcastStream, model: model);
  }
  // Widget? getBannerView(Stream<dynamic> stream, Map<String, dynamic> config) {
  //   BannerModel model = BannerModel.fromJson(config);
  //   var broadcastStream =
  //       stream.map<BannerItem>((data) => BannerItem.fromJson(data));
  //   return BannerView(stream: broadcastStream, model: model);
  // }

  Widget? getQuickAccessView(
      Stream<dynamic> stream, Map<String, dynamic> config) {
    QuickAccessModel model = QuickAccessModel.fromJson(config);
    var broadcastStream = stream.map<QuickAccessPayloadData>(
        (data) => QuickAccessPayloadData.fromJson(data));
    return QuickAccessView(stream: broadcastStream, model: model);
  }
}
