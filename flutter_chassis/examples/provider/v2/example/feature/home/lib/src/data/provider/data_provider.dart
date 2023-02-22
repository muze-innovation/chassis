import 'dart:async';

import 'package:chassis_core/core.dart';
import 'package:chassis_annotation/annotation.dart' as annotation;

part 'data_provider.chassis.dart';

@annotation.DataProvider()
class DataProvider extends _DataProvider {}

/// (Example) Instance of data provider
DataProvider dataProvider = DataProvider();
