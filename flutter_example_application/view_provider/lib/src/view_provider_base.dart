import 'dart:async';
import 'package:chassis/view_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:view_provider/example/banner/banner_model.dart';
import 'package:view_provider/example/banner/banner_widget.dart';
import 'package:view_provider/example/quick_access/quick_access_model.dart';
import 'package:view_provider/example/quick_access/quick_access_widget.dart';
import 'package:view_provider/src/view_type_constant.dart';

abstract class ViewProvider implements IViewProvider {
  Widget getBannerView(Stream<BannerItem> stream, BannerModel model);
  Widget getQuickAccessView(
      Stream<QuickAccessPayloadData> stream, QuickAccessModel model);

  @override
  Widget getView(Stream stream, ChassisItem item) {
    switch (item.viewType) {
      case ViewTypeConstant.Banner:
        var bannerModel = BannerModel.fromJson(item.toJson());
        var broadcastStream =
            stream.map<BannerItem>((data) => BannerItem.fromJson(data));
        return getBannerView(broadcastStream, bannerModel);
      case ViewTypeConstant.QuickAccess:
        var quickAccessModel = QuickAccessModel.fromJson(item.toJson());
        var broadcastStream = stream.map<QuickAccessPayloadData>(
            (data) => QuickAccessPayloadData.fromJson(data));
        return getQuickAccessView(broadcastStream, quickAccessModel);

      default:
        return Container();
    }
  }
}

//User's Implemented ViewProvider
class AppViewProvider extends ViewProvider {
  @override
  Widget getBannerView(Stream<BannerItem> stream, BannerModel model) {
    return BannerWidget(stream: stream, model: model);
  }

  @override
  Widget getQuickAccessView(
      Stream<QuickAccessPayloadData> stream, QuickAccessModel model) {
    return QuickAccessWidget(stream: stream, model: model);
  }
}
