import 'dart:async';
import 'package:chassis/interfaces/i_data_provider.dart';
import 'package:chassis/models/chassis_request.dart';
import 'package:data_provider/model/banner_output.dart';
import 'package:data_provider/model/quick_access_item_output.dart';
import 'package:data_provider/src/quick_access_item_data_provider.dart';
import '../constans/constants.dart';
import '../model/banner_input.dart';
import 'banner_data_provider.dart';

abstract class DataProvider implements IDataProvider {
  final List<StreamSubscription> _subscriptionRegisters = [];
  Stream<BannerOutput> getBanner(BannerInput banner);
  Stream<QuickAccessItemOutput> getQuickAccessItem();
  @override
  void getData(StreamController<dynamic> controller, ChassisRequest request) {
    switch (request.resolvedWith) {
      case DataProviderConstans.getBanner:
        final subscription =
            getBanner(BannerInput.fromJson(request.input)).listen((event) {
          controller.add(event.toJson());
        });
        _subscriptionRegisters.add(subscription);
        break;
      case DataProviderConstans.getQuickAccessItem:
        final subscription = getQuickAccessItem().listen((event) {
          controller.add(event.toJson());
        });
        _subscriptionRegisters.add(subscription);
        break;
      default:
    }
  }

  @override
  void dispose() {
    for (var subscription in _subscriptionRegisters) {
      subscription.cancel();
    }
    _subscriptionRegisters.clear();
  }
}

class AppDataProvider extends DataProvider {
  final _bannerDataProvider = BannerDataProvider();
  final _quickAccessItemDataProvider = QuickAccessItemDataProvider();

  @override
  Stream<BannerOutput> getBanner(BannerInput banner) {
    return _bannerDataProvider.getData(banner.slug);
  }

  @override
  Stream<QuickAccessItemOutput> getQuickAccessItem() {
    return _quickAccessItemDataProvider.getData();
  }
}
