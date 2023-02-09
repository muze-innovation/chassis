/// Darts
import 'dart:async';

/// Packages
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

/// Local Files
import '../models/chassis_item.dart';
import '../models/chassis_payload_type.dart';
import '../models/chassis_request.dart';
import '../models/chassis_response.dart';
import 'data_provider.dart';
import 'schema_validator.dart';
import 'view_provider.dart';

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
  late DataProvider _dataProvider;
  late ViewProvider _viewProvider;

  // The `SchemaValidator` will validate between payload and json schema.
  //
  // required: `view_spec`, `resolver_spec` into assets folder in application
  // and set assets path in `pubspec.yaml`
  //
  // e.g. [pubspec.yaml]
  // - assets/view_spec.json
  // - assets/resolver_spec.json
  late ISchemaValidator _schemaValidator;

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
      {required DataProvider dataProvider,
      required ViewProvider viewProvider,
      required ISchemaValidator schemaValidator}) {
    _dataProvider = dataProvider;
    _viewProvider = viewProvider;
    _schemaValidator = schemaValidator;
  }

  /// ## Public Methods
  /// Get list views using ChassisItem
  Iterable<Widget> getViews(Iterable<ChassisItem> items) {
    /// Create widget with payload type is static or remote
    List<Widget> widgets = [];
    for (var item in items) {
      final widget = getView(item);
      if (widget != null) {
        widgets.add(widget);
      }
    }

    /// Return all widgets after created.
    return widgets;
  }

  /// Get view using ChassisItem
  Widget? getView(ChassisItem item) {
    /// Validate item spec
    if (!_schemaValidator.validate(item)) {
      return null;
    }

    /// Create StreamController
    final subject = BehaviorSubject();
    _subjects.add(subject);

    /// Validate response spec
    final validatedTransfrom = subject.stream.transform(_validateOutput(item));

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

    /// Get view from ViewProvider,
    /// and link view with data by using Stream
    final widget = _viewProvider.getView(validatedTransfrom, item);

    /// Return widget
    return widget;
  }

  // Close all the opened subjects.
  void dispose() async {
    for (var subject in _subjects) {
      subject.close();
    }
    _subjects.clear();
  }

  /// ## Private Methods
  // Validate Spec
  StreamTransformer<dynamic, dynamic> _validateOutput(ChassisItem item) {
    return StreamTransformer<dynamic, dynamic>.fromHandlers(
        handleData: (data, sink) {
      final response = ChassisResponse(
          resolvedWith: item.payload.resolvedWith ?? '', output: data);
      if (item.payload.type == PayloadType.static ||
          _schemaValidator.validate(response)) {
        sink.add(data);
      } else {
        sink.addError('response is invalid');
      }
    });
  }
}
