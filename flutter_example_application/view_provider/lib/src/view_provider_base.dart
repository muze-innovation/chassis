import 'dart:async';
import 'package:chassis/view_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:view_provider/example/banner/banner_widget.dart';
import 'package:view_provider/example/quick_access/quick_access_widget.dart';
import 'package:view_provider/src/chassis_model.dart';
import 'package:view_provider/src/view_type_constant.dart';
import 'package:view_provider/action/action.dart';

abstract class ViewProvider implements IViewProvider {
  Widget getBannerView(Stream<PayloadData> stream, ChassisModel model);
  Widget getQuickAccessView(Stream<PayloadData> stream, ChassisModel model);

  @override
  Widget? getView(Stream stream, ChassisItem item) {
    var model = ChassisModel.fromChassisItem(item);
    var broadcastStream = stream.map((data) => PayloadData.fromJson(data));
    switch (item.viewType) {
      case ViewTypeConstant.banner:
        return getBannerView(broadcastStream, model);
      case ViewTypeConstant.quickAccess:
        return getQuickAccessView(broadcastStream, model);
      default:
        return null;
    }
  }
}

//User's Implemented ViewProvider
class AppViewProvider extends ViewProvider {
  // Can pass action delegator here if want to handle it.
  final IAction delegate;
  AppViewProvider({required this.delegate});

  @override
  Widget getBannerView(Stream<PayloadData> stream, ChassisModel model) {
    // return BannerWidget(stream: stream, model: model, delegate: delegate);
    return InheritedBanner(
      stream: stream,
      model: model,
      delegate: delegate,
      child: InheritedBannerDemo(),
    );
  }

  @override
  Widget getQuickAccessView(Stream<PayloadData> stream, ChassisModel model) {
    return QuickAccessWidget(stream: stream, model: model);
  }
}
