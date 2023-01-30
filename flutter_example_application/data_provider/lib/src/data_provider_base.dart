import 'dart:async';
import 'package:chassis/constants/constants.dart';
import 'package:chassis/interfaces/i_data_provider.dart';
import '../constans/constants.dart';
import 'banner_data_provider.dart';

class DataProvider implements IDataProvider {
  final _bannerDataProvider = BannerDataProvider();
  @override
  void getData(StreamController controller, Map<String, dynamic> payload) {
    switch (payload[DataProviderConstans.resolvedWith]) {
      case DataProviderConstans.getBanner:
        _bannerDataProvider.getData(controller,
            payload[ResovlerSpecConstants.input][DataProviderConstans.slug]);
        break;
      default:
    }
  }
}
