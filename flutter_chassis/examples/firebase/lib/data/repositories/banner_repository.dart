import '../../utils/readability.dart';

mixin IBannerRepository {
  Future<dynamic> getData(String slug);
}

class BannerRepository implements IBannerRepository {
  @override
  Future<dynamic> getData(String slug) async {
    final banner =
        await Readability.readFrom('assets/banner.json').then((data) {
      return data;
    });
    return Future.delayed(const Duration(seconds: 3)).then((value) => banner);
  }
}
