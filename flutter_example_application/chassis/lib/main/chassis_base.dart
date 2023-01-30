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
  static final Chassis _chassis = Chassis._();

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
  /// Chassis.setup(viewProvider, dataProvider);
  /// ```
  ///
  static setup(
      {required IDataProvider dataProvider,
      required IViewProvider viewProvider}) {
    _chassis._dataProvider = dataProvider;
    _chassis._viewProvider = viewProvider;
  }

  /// ## Chassis Static Methods
  static List<Widget> getView(Map<String, dynamic> data) {
    /// validate DataProvider & ViewProvider
    final dataProvider = _chassis._dataProvider;
    final viewProvider = _chassis._viewProvider;
    if (dataProvider == null || viewProvider == null) {
      throw Exception(
          'Chassis need to setup the ViewProvider & DataProvider before use it.');
    }

    /// validate item
    List<dynamic>? items = data[Constants.items];
    if (items == null) {
      throw Exception(
          'The JSON response does not have the `items` key, please check it.');
    }

    /// Create widget with payload type is static or remote
    List<Widget> widgets = [];
    for (var item in items) {
      StreamController controller = StreamController.broadcast();
      var widget = viewProvider.getView(controller.stream, item);
      if (widget != null) {
        widgets.add(widget);

        var payload = item[ViewSpecConstants.payload];
        var payloadType = payload[ViewSpecConstants.payloadType];
        var payloadData = payload[ViewSpecConstants.payloadData];

        if (payloadType == 'static') {
          controller.add(payloadData);
        } else if (payloadType == 'remote') {
          dataProvider.getData(controller, payload);
        }
      }
    }

    /// Return all widget after created.
    return widgets;
  }

  /// ## Chassis Private Methods
  bool _validate(Map<String, dynamic> item) {
    return false;
  }
}
