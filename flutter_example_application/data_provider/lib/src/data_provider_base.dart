import 'dart:async';
<<<<<<< HEAD
import 'package:chassis/interfaces/i_data_provider.dart';
=======
import 'package:chassis/data_provider.dart';
>>>>>>> feature/chassis-flutter
import 'package:data_provider/src/quick_access_item_data_provider.dart';
import '../constans/constants.dart';
import '../model/banner_input.dart';
import 'banner_data_provider.dart';

<<<<<<< HEAD
abstract class ADataProvider implements IDataProvider {
  void getBanner(StreamController controller, BannerInput banner);
  void getQuickAccessItem(StreamController controller);
}

class DataProvider extends ADataProvider {
  final _bannerDataProvider = BannerDataProvider();
  final _quickAccessItemDataProvider = QuickAccessItemDataProvider();
=======
import 'package:data_provider/models/banner_input.dart';
import 'package:data_provider/models/banner_output.dart';

// class DataProvider implements IDataProvider {
//   final _bannerDataProvider = BannerDataProvider();
//   final _quickAccessItemDataProvider = QuickAccessItemDataProvider();
//   @override
//   void getData(StreamController<dynamic> controller, ChassisResolver resolver) {
//     switch (resolver.resolvedWith) {
//       case DataProviderConstans.getBanner:
//         _bannerDataProvider.getData(
//             controller, resolver.input[DataProviderConstans.slug]);
//         break;
//       case DataProviderConstans.getQuickAccessItem:
//         _quickAccessItemDataProvider.getData(controller);
//         break;
//       default:
//     }
//   }
// }

/// Chassis(backend)
abstract class DataProvider implements IDataProvider {
  Stream<BannerOutput> getbanner(BannerInput input);

>>>>>>> feature/chassis-flutter
  @override
  void getData(StreamController<dynamic> controller, ChassisRequest request) {
    switch (request.resolvedWith) {
      case DataProviderConstans.getBanner:
<<<<<<< HEAD
        getBanner(controller, BannerInput.fromJson(payload));
        break;
      case DataProviderConstans.getQuickAccessItem:
        getQuickAccessItem(controller);
=======
        final input = BannerInput.fromRequest(request);
        final stream = getbanner(input);
        controller.addStream(stream.map((event) => event.toJson()));
        break;
      case DataProviderConstans.getQuickAccessItem:
>>>>>>> feature/chassis-flutter
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

/// User Implementation
class AppDataProvider extends DataProvider {
  @override
  Stream<BannerOutput> getbanner(BannerInput input) {
    return OlderRepo()
        .getBanner()
        .asStream()
        .map((event) => BannerOutput.fromJson(event));
  }
}

class OlderRepo {
  Future<dynamic> getBanner() {
    return Future.delayed(Duration(seconds: 3))
        .then((value) => {'title': 'ข้าวเหนียวไก่ยาง', 'asset': 'asdfasfd'});
  }
}
