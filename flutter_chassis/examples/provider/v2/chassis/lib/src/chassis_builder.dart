import '../core.dart';
import 'chassis.dart';

/// Builder for Chassis
class ChassisBuilder {
  final _chassis = Chassis();

  void addDataProviders(List<DataProviderBase> providers) {
    _chassis.addDataProviders(providers);
  }

  Chassis build() => _chassis;
}
