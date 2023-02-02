import 'dart:async';
import 'package:chassis/interfaces/i_data_provider.dart';
import 'package:data_provider/src/quick_access_item_data_provider.dart';
import '../constans/constants.dart';
import '../model/banner_input.dart';
import 'banner_data_provider.dart';

abstract class ADataProvider implements IDataProvider {
  void getBanner(StreamController controller, BannerInput banner);
  void getQuickAccessItem(StreamController controller);
}

class DataProvider extends ADataProvider {
  final _bannerDataProvider = BannerDataProvider();
  final _quickAccessItemDataProvider = QuickAccessItemDataProvider();
  @override
  void getData(StreamController controller, Map<String, dynamic> payload) {
    switch (payload[DataProviderConstans.resolvedWith]) {
      case DataProviderConstans.getBanner:
        getBanner(controller, BannerInput.fromJson(payload));
        break;
      case DataProviderConstans.getQuickAccessItem:
        getQuickAccessItem(controller);
        break;
      default:
    }
  }

  @override
  void getBanner(StreamController controller, BannerInput banner) {
    print("DataProvider banner is $banner");
    _bannerDataProvider.getData(controller, banner.input.slug);
  }

  @override
  void getQuickAccessItem(StreamController controller) {
    _quickAccessItemDataProvider.getData(controller);
  }
}
