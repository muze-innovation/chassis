// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_provider.dart';

// **************************************************************************
// DataProviderGenerator
// **************************************************************************

abstract class _DataProvider extends DataProviderBase {
  _DataProvider({required BannerDataResolver mBannerDataResolver})
      : _resolverRouteTable = {...mBannerDataResolver.routeTable};

  final Map<String, DataResolver> _resolverRouteTable;

  @override
  Map<String, DataProviderBase> get routeTable =>
      _resolverRouteTable.map((key, value) => MapEntry(key, this));
  @override
  void getData(
    StreamController<Map<String, dynamic>> controller,
    Request request,
  ) {
    _resolverRouteTable[request.resolvedWith]?.getData(controller, request);
  }
}
