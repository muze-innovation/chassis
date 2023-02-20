/// Darts
import 'dart:convert';

/// Packages
import 'package:flutter/foundation.dart';
import 'package:json_schema/json_schema.dart';

/// Local Files
import '../models/chassis_item.dart';
import '../models/chassis_response.dart';
import 'constants.dart';

abstract class ISchemaValidator {
  bool validate<T>(T object);
}

class SchemaValidator implements ISchemaValidator {
  late dynamic _schema;

  SchemaValidator({required dynamic schema}) {
    _schema = schema;
  }

  @override
  bool validate<T>(T object) {
    if (object is ChassisItem) {
      return _isValidSchema(object.toJson());
    } else if (object is ChassisResponse) {
      return _isValidSchema(object.output);
    } else {
      return false;
    }
  }

  bool _isValidSchema(Map<String, dynamic> object) {
    final String? viewType = object[ViewSpecConstants.viewType];
    final viewSchema = JsonSchema.create(_schema);
    final isValid = viewSchema.validate(object).isValid;
    debugPrint(
        '[schema_validator] => [Schema: $viewType] errors: ${viewSchema.validate(object).errors}, isValid: $isValid');
    return isValid;
  }
}
