import 'dart:io';
import 'dart:async';
import 'package:chassis/interface.dart';
import 'package:chassis/constants/constants.dart';
import 'package:flutter/material.dart';

/// Chassis is a library for widget management.
///
/// To use, import `package:chassis/chassis.dart`.
///
class Chassis {
  static Chassis _chassis = Chassis._();

  /// The `version` is a version of the Chassis library.
  static get version => '1.0.0';

  /// The `DataProvider` will provide a data from local/network to the Chassis
  /// library.
  ///
  /// By default is not required in some cases, you can set it be
  /// using `setViewProvider()`
  ///
  /// e.g. `Chassis.setDataProvider(dataProvider);`
  IDataProvider? _dataProvider;

  /// The `ViewProvider` will provide a widget to the Chassis library.
  ///
  /// By default is required, you can set it be using `setViewProvider()`
  ///
  /// e.g. `Chassis.setViewProvider(viewProvider);`
  IViewProvider? _viewProvider;

  /// ## Private Constructor
  Chassis._();

  /// ## Initial Setting
  ///
  /// Chassis must set the ViewProvider and DataProvider (data provider is
  /// not required in some cases)
  ///
  /// ```import 'package:chassis/chassis.dart'
  /// Chassis.setDataProvider(dataProvider);
  //  Chassis.setViewProvider(viewProvider);
  /// ```
  static setDataProvider(IDataProvider dataProvider) {
    _chassis._dataProvider = dataProvider;
  }

  static setViewProvider(IViewProvider viewProvider) {
    _chassis._viewProvider = viewProvider;
  }

  /// ## Chassis Static Methods
  static List<Widget> getView(Map<String, dynamic> data) {
    // Remove this default value in widget if the ViewProvider & DataProvider is done.
    List<Widget> widgets = [
      Text('example widget 01'),
      Text('example widget 02'),
      Text('example widget 03')
    ];

    final viewProvider = _chassis._viewProvider;
    final dataProvider = _chassis._dataProvider;
    if (viewProvider == null || dataProvider == null) {
      return widgets;
    }

    if (data[Constants.version] != version) {
      return widgets;
    }

    List<Map<String, dynamic>>? items = data[Constants.items];
    if (items == null) {
      return widgets;
    }

    for (var item in items) {
      StreamController controller = StreamController.broadcast();
      widgets.add(viewProvider.getView(controller.stream, item));

      var payload = item[ViewSpecConstants.payload];
      var payloadType = payload[ViewSpecConstants.payloadType];
      var payloadData = payload[ViewSpecConstants.payloadData];

      if (payloadType == 'static') {
        controller.add(payloadData);
      } else if (payloadType == 'remote') {
        dataProvider.getData(controller, payload);
      }
    }

    return widgets;
  }

  /// ## Chassis Private Methods
  bool _validate(Map<String, dynamic> item) {
    return false;
  }
}
