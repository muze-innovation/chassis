/// Darts
import 'dart:async';

/// Packages
import 'package:flutter_chassis/flutter_chassis.dart';

/// Local Files
import 'constanst.dart';
import 'models/banner_input.dart';
import 'models/banner_output.dart';
import 'models/quick_access_item_output.dart';
import 'repositories/banner_repository.dart';
import 'repositories/product_repository.dart';

/// Auto-generate from the Chassis-backend
abstract class BaseDataProvider implements DataProvider {
  Stream<BannerOutput> getBanner(BannerInput banner);
  Stream<QuickAccessOutput> getQuickAccessItem();

  @override
  void getData(StreamController<dynamic> controller, ChassisRequest request) {
    switch (request.resolvedWith) {
      case DataProviderConstans.getBanner:
        final input = BannerInput.fromJson(request.input);
        final stream = getBanner(input).map((event) => event.toJson());
        controller.addStream(stream);
        break;
      case DataProviderConstans.getQuickAccessItem:
        final stream = getQuickAccessItem().map((event) => event.toJson());
        controller.addStream(stream);
        break;
      default:
        break;
    }
  }
}

/// The application must extends `BaseDataProvider` by themself
class AppDataProvider extends BaseDataProvider {
  final _bannerRepository = BannerRepository();
  final _productRepository = ProductRepository();
  final List<StreamSubscription> _subscriptionRegisters = [];

  //Modify `getData` function for fix firebase issue
  @override
  void getData(StreamController<dynamic> controller, ChassisRequest request) {
    switch (request.resolvedWith) {
      case DataProviderConstans.getBanner:
        final input = BannerInput.fromJson(request.input);
        final stream = getBanner(input).map((event) => event.toJson());
        final subscription = stream.listen((event) {
          controller.add(event);
        });
        _subscriptionRegisters.add(subscription);
        break;
      case DataProviderConstans.getQuickAccessItem:
        final stream = getQuickAccessItem().map((event) => event.toJson());
        final subscription = stream.listen((event) {
          controller.add(event);
        });
        _subscriptionRegisters.add(subscription);
        break;
      default:
        break;
    }
  }

  @override
  Stream<BannerOutput> getBanner(BannerInput banner) {
    return _bannerRepository
        .getData(banner.slug)
        .asStream()
        .map((event) => BannerOutput.fromJson(event));
  }

  @override
  Stream<QuickAccessOutput> getQuickAccessItem() {
    return _productRepository
        .streamProductReccomend()
        .map((event) => QuickAccessOutput.fromJson(event.data()));
  }

  void dispose() {
    for (var subscription in _subscriptionRegisters) {
      subscription.cancel();
    }
    _subscriptionRegisters.clear();
  }
}
