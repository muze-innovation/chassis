import 'dart:async';
import 'package:chassis/view_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:view_provider/example/Banner/bannerModel.dart';
import 'package:view_provider/example/Banner/bannerView.dart';
import 'package:view_provider/example/QuickAccess/quickAccessModel.dart';
import 'package:view_provider/example/QuickAccess/quickAccessView.dart';

class ViewType {
  static const Banner = "Banner";
  static const QuickAccess = "QuickAccess";
}

abstract class ViewProvider implements IViewProvider {
  Widget getBannerView(Stream<BannerItem> stream, BannerModel model);
  Widget getQuickAccessView(
      Stream<QuickAccessPayloadData> stream, QuickAccessModel model);

  @override
  Widget getView(Stream stream, ChassisItem item) {
    switch (item.viewType) {
      case ViewType.Banner:
        print(item.toJson());
        var bannerModel = BannerModel.fromJson(item.toJson());
        print(bannerModel.toString());
        var broadcastStream =
            stream.map<BannerItem>((data) => BannerItem.fromJson(data));
        return getBannerView(broadcastStream, bannerModel);
      case ViewType.QuickAccess:
        var quickAccessModel = QuickAccessModel.fromJson(item.toJson());
        var broadcastStream = stream.map<QuickAccessPayloadData>(
            (data) => QuickAccessPayloadData.fromJson(data));
        return getQuickAccessView(broadcastStream, quickAccessModel);
      default:
        return Container();
    }
  }
}

class AppViewProvider extends ViewProvider {
  @override
  Widget getBannerView(Stream<BannerItem> stream, BannerModel model) {
    return BannerView(stream: stream, model: model);
  }

  @override
  Widget getQuickAccessView(
      Stream<QuickAccessPayloadData> stream, QuickAccessModel model) {
    return QuickAccessView(stream: stream, model: model);
  }
}
