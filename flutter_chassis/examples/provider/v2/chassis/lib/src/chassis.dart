import '../core.dart';

class Chassis {
  final Map<String, DataProviderBase> _routeTable = Map();

  void addDataProviders(List<DataProviderBase> providers) {
    providers.forEach((provider) {
      _routeTable.addAll(provider.routeTable);
    });
  }

  DataProviderBase? _getDataProvider(Request request) {
    return _routeTable[request.resolvedWith];
  }
}
