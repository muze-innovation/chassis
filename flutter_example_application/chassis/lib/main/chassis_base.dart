/// Foundation library
import 'dart:async';

import 'package:chassis/models/chassis_response.dart';
import 'package:flutter/material.dart';

/// External library
import 'package:rxdart/rxdart.dart';

/// Internal library
import 'package:chassis/data_provider.dart';
import 'package:chassis/view_provider.dart';
import 'package:chassis/validator/schema_validator.dart';

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
      {required IDataProvider dataProvider,
      required IViewProvider viewProvider,
      required ISchemaValidator schemaValidator}) {
    _dataProvider = dataProvider;
    _viewProvider = viewProvider;
    _schemaValidator = schemaValidator;
  }

  /// ## Chassis Public Methods
  Iterable<Widget> getViews(Iterable<ChassisItem> items) {
    /// Create widget with payload type is static or remote
    List<Widget> widgets = [];
    for (var item in items) {
      /// Create subject
      final subject = BehaviorSubject();
      _subjects.add(subject);

      /// Transfrom stream
      final validatedTransfrom = subject.stream
          .transform(validateOutput(item.payload.resolvedWith ?? ''));

      /// validate schema
      if (!_schemaValidator.validate(item)) {
        subject.addError('item is invalid');
        continue;
      }

      /// Add widget to the list of widgets
      widgets.add(_viewProvider.getView(validatedTransfrom, item));

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
  void dispose() async {
    for (var subject in _subjects) {
      await subject.drain();
      subject.close();
    }
    _subjects.clear();
  }

  StreamTransformer<dynamic, dynamic> validateOutput(String resolveWith) {
    return StreamTransformer<dynamic, dynamic>.fromHandlers(
        handleData: (data, sink) {
      final response = ChassisResponse(resolvedWith: resolveWith, output: data);
      _schemaValidator.validate(response)
          ? sink.add(data)
          : sink.addError('response is invalid');
    });
  }
}
