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
  Stream<BannerOutput> getBanner(BannerInput banner);
  Stream<QuickAccessItemOutput> getQuickAccessItem(StreamController controller);
  @override
  void getData(StreamController<dynamic> controller, ChassisRequest request) {
    switch (request.resolvedWith) {
      case DataProviderConstans.getBanner:
        controller.addStream(getBanner(BannerInput.fromJson(request.input)));
        break;
      case DataProviderConstans.getQuickAccessItem:
        // controller.addStream(getQuickAccessItem(controller));
        break;
      default:
    }
  }
}

class AppDataProvider extends DataProvider {
  final _bannerDataProvider = BannerDataProvider();
  final _quickAccessItemDataProvider = QuickAccessItemDataProvider();
  @override
  Stream<BannerOutput> getBanner(BannerInput banner) {
    print("  banner is $banner");
    return _bannerDataProvider.getData(banner.slug);
  }

  @override
  Stream<QuickAccessItemOutput> getQuickAccessItem(
      StreamController controller) {
    return _quickAccessItemDataProvider.getData(controller);
  }
}
