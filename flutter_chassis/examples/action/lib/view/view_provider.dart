/// Darts
import 'dart:async';

/// Packages
import 'package:flutter/widgets.dart';
import 'package:flutter_chassis/flutter_chassis.dart';

/// Local Files
import 'constanst.dart';
import 'models/banner_model.dart';
import 'models/quick_access_model.dart';
import 'widgets/banner_widget.dart';
import 'widgets/quick_access_widget.dart';
import '../action/action.dart';

/// Auto-generate from the Chassis-backend
abstract class BaseViewProvider implements ViewProvider {
  Widget getBannerView(Stream<BannerItem> stream, BannerModel model);
  Widget getQuickAccessView(
      Stream<QuickAccessPayloadData> stream, QuickAccessModel model);

  @override
  Widget getView(Stream stream, ChassisItem item) {
    switch (item.viewType) {
      case ViewType.banner:
        var bannerModel = BannerModel.fromJson(item.toJson());
        var broadcastStream =
            stream.map<BannerItem>((data) => BannerItem.fromJson(data));
        return getBannerView(broadcastStream, bannerModel);

      case ViewType.quickAccess:
        var quickAccessModel = QuickAccessModel.fromJson(item.toJson());
        var broadcastStream = stream.map<QuickAccessPayloadData>(
            (data) => QuickAccessPayloadData.fromJson(data));
        return getQuickAccessView(broadcastStream, quickAccessModel);

      default:
        return Container();
    }
  }
}

/// The application must extends `BaseViewProvider` by themself
class AppViewProvider extends BaseViewProvider {
  // Can pass action delegator here if needed.
  final ActionDelegate delegate;
  AppViewProvider({required this.delegate});

  // Return any types of widget
  @override
  Widget getBannerView(Stream<BannerItem> stream, BannerModel model) {
    return InheritedBanner(
        stream: stream, model: model, delegate: delegate, child: Banner());
  }

  @override
  Widget getQuickAccessView(
      Stream<QuickAccessPayloadData> stream, QuickAccessModel model) {
    return QuickAccessView(stream: stream, model: model);
  }
}
