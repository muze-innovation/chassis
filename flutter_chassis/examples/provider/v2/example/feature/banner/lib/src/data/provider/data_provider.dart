import 'dart:async';

import 'package:chassis_core/core.dart';
import 'package:chassis_annotation/annotation.dart' as annotation;

import '../resolver/banner/banner_data_resolver.dart';
import '../resolver/data_resolver.dart';

part 'data_provider.chassis.dart';

/// A concrete of data provider.
/// Version 2.0
/// Created by User (Generated by build_runner)
@annotation.DataProvider(resolvers: [BannerDataResolver])
class DataProvider extends _DataProvider {
  DataProvider({required super.mBannerDataResolver});
}
