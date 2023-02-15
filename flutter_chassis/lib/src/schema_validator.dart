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
  late dynamic _viewSpec;
  late dynamic _resolverSpec;

  SchemaValidator({required dynamic viewSpec, required dynamic resolverSpec}) {
    _viewSpec = viewSpec;
    _resolverSpec = resolverSpec;
  }

  @override
  bool validate<T>(T object) {
    if (object is ChassisItem) {
      return _isValidSchema(object.toJson()) &&
          _isValidPayload(object.toJson());
    } else if (object is ChassisResponse) {
      return _isValidPayloadOutput(object.resolvedWith, object.output);
    } else {
      return false;
    }
  }

  bool _isValidPayload(Map<String, dynamic> object) {
    final payloadType =
        object[ViewSpecConstants.payload][ViewSpecConstants.payloadType];

    switch (payloadType) {
      case 'static':
        return _isValidPayloadStatic(object);
      case 'remote':
        return _isValidPayloadRemoteInput(object);
      default:
        return false;
    }
  }

  bool _isValidSchema(Map<String, dynamic> object) {
    Map<String, dynamic> viewSpec = json.decode(json.encode(_viewSpec));
    final String viewType = object[ViewSpecConstants.viewType];
    final Map<String, dynamic> viewSpecMapByVType = viewSpec[viewType];
    final Map<String, dynamic> _ =
        viewSpecMapByVType[ViewSpecConstants.properties]
            .remove(ViewSpecConstants.payload);
    final viewSchema = JsonSchema.create(viewSpecMapByVType);
    final isValid = viewSchema.validate(object).isValid;
    debugPrint(
        '[schema_validator] => [Schema: $viewType] errors: ${viewSchema.validate(object).errors}, isValid: $isValid');
    return isValid;
  }

  bool _isValidPayloadStatic(Map<String, dynamic> object) {
    final String viewType = object[ViewSpecConstants.viewType];
    final Map<String, dynamic> payload = _viewSpec[viewType]
        [ViewSpecConstants.properties][ViewSpecConstants.payload];
    final payloadSchema = JsonSchema.create(payload);
    final payloadData =
        object[ViewSpecConstants.payload][ViewSpecConstants.payloadData];
    final isValid = payloadSchema.validate(payloadData).isValid;
    debugPrint(
        '[schema_validator] => [Payload: $viewType] errors: ${payloadSchema.validate(payloadData).errors}, isValid: $isValid');
    return isValid;
  }

  bool _isValidPayloadRemoteInput(Map<String, dynamic> object) {
    final String resolvedWith =
        object[ViewSpecConstants.payload][ViewSpecConstants.resolvedWith];
    List<dynamic> requires =
        _resolverSpec[resolvedWith][ResovlerSpecConstants.required];
    if (requires.contains(ResovlerSpecConstants.input)) {
      final itemInput =
          object[ViewSpecConstants.payload][ViewSpecConstants.input];
      final inputSpec = _resolverSpec[resolvedWith]
          [ResovlerSpecConstants.properties][ResovlerSpecConstants.input];
      final JsonSchema inputSchema = JsonSchema.create(inputSpec);
      final bool isValid = inputSchema.validate(itemInput).isValid;
      debugPrint(
          '[schema_validator] => [Payload(Input): $resolvedWith] errors: ${inputSchema.validate(itemInput).errors}, isValid: $isValid');
      return isValid;
    }
    debugPrint(
        '[schema_validator] => [Payload(Input): $resolvedWith] unrequired input');
    return true;
  }

  bool _isValidPayloadOutput(String resolvedWith, Map<String, dynamic> data) {
    final outputSpec = _resolverSpec[resolvedWith]
        [ResovlerSpecConstants.properties][ResovlerSpecConstants.output];
    if (outputSpec == null) {
      return false;
    }
    final JsonSchema outputSchema = JsonSchema.create(outputSpec);
    final bool isValid = outputSchema.validate(data).isValid;
    debugPrint(
        '[schema_validator] => [Payload(Output): $resolvedWith] errors: ${outputSchema.validate(data).errors}, isValid: $isValid');
    return isValid;
  }
}
