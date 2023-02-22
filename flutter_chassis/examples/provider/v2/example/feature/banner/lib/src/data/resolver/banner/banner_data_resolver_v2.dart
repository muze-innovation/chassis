import 'package:banner/src/data/resolver/data_resolver.dart';
import 'package:chassis_annotation/annotation.dart' as annotation;
import '../../../model/banner_input.dart';
import '../../../model/banner_output.dart';
import '../../repo/banner_repository.dart';

part 'banner_data_resolver_v2.chassis.dart';

/// Example for creating a data resolver of banner
/// Created by User
@annotation.DataResolver()
class BannerDataResolverV2 extends DataResolver {
  final BannerRepository _repository;

  BannerDataResolverV2({required BannerRepository repository})
      : _repository = repository;

  @override
  Stream<BannerOutput>? getBannerV2(BannerInput input) {
    return _repository.getBanner(input.slug).asStream().map((event) =>
        BannerOutput(asset: event.asset, placeholder: event.placeholder));
  }

  @override
  Map<String, DataResolver> get routeTable =>
      _getRouteTableForBannerDataResolverV2(this);
}
