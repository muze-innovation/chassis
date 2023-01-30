import 'dart:async';
import 'package:chassis/constants/constants.dart';
import 'package:chassis/interfaces/i_data_provider.dart';
import 'package:data_provider/src/quick_access_item_data_provider.dart';
import '../constans/constants.dart';
import 'banner_data_provider.dart';

class DataProvider implements IDataProvider {
  final _bannerDataProvider = BannerDataProvider();
  final _quickAccessItemDataProvider = QuickAccessItemDataProvider();
  @override
  void getData(StreamController controller, Map<String, dynamic> payload) {
    switch (payload[DataProviderConstans.resolvedWith]) {
      case DataProviderConstans.getBanner:
        _bannerDataProvider.getData(controller,
            payload[ResovlerSpecConstants.input][DataProviderConstans.slug]);
        break;
      case DataProviderConstans.getQuickAccessItem:
        _quickAccessItemDataProvider.getData(controller);
        break;
      default:
    }
  }
}
