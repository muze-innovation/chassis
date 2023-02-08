/// Foundation library
import 'dart:async';

import 'package:flutter/material.dart';

/// External library
import 'package:rxdart/rxdart.dart';

/// Internal library
import 'package:chassis/data_provider.dart';
import 'package:chassis/view_provider.dart';

/// Chassis is a library for widget management.
///
/// To use, import `package:chassis/chassis.dart`.
///
class Chassis {
  /// The `version` is a version of the Chassis library.
  static get version => '1.0.0';

  /// The `DataProvider` and `ViewProvider` will provide a data and a widget
  /// from local/network to the Chassis library.
  ///
  /// By default is not required `DataProvider` in some cases, you can set it be
  /// using `Chassis()`
  ///
  /// ```
  ///   final dataProvider = DataProvider();
  ///   final viewProvider = ViewProvider();
  ///   final chassis = Chassis(dataProvider: dataProvider, viewProvider:
  ///                     viewProvider);
  /// ```
  ///
  late IDataProvider _dataProvider;
  late IViewProvider _viewProvider;

  /// Declarations of private property in Chassis
  final List<BehaviorSubject> _subjects = [];

  /// ## Constructor - Initial Setting
  ///
  /// Chassis must set the ViewProvider and DataProvider (data provider is
  /// not required in some cases)
  ///
  /// ```import 'package:chassis/chassis.dart'
  /// Chassiss(viewProvider, dataProvider);
  /// ```
  ///
  Chassis(
      {required IDataProvider dataProvider,
      required IViewProvider viewProvider}) {
    _dataProvider = dataProvider;
    _viewProvider = viewProvider;
  }

  /// ## Chassis Public Methods
  Iterable<Widget> getViews(Iterable<ChassisItem> items) {
    /// Create widget with payload type is static or remote
    List<Widget> widgets = [];
    for (var item in items) {
      /// Create subject
      final subject = BehaviorSubject();
      _subjects.add(subject);

      /// Add widget to the list of widgets
      widgets.add(_viewProvider.getView(subject.stream, item));

      /// Manage data by payload type
      switch (item.payload.type) {
        case PayloadType.static:
          subject.add(item.payload.data);
          break;
        case PayloadType.remote:
          final request = ChassisRequest.fromJson(item.payload.toJson());
          _dataProvider.getData(subject, request);
          break;
      }
    }

    /// Return all widget after created.
    return widgets;
  }

  // Close all the opened subjects.
  dispose() {
    for (var subject in _subjects) {
      subject.close();
    }
    _dataProvider.dispose();
    _subjects.clear();
  }

  /// ## Chassis Private Methods
  bool _validate(Map<String, dynamic> item) {
    return false;
  }
}
