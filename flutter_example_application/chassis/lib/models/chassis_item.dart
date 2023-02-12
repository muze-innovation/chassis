import 'package:chassis/models/chassis_payload.dart';

class ChassisItem {
  ChassisItem(
      {required this.id,
      required this.viewType,
      this.attributes,
      this.parameters,
      this.action,
      this.error,
      required this.payload});

  final String id;
  final String viewType;
  final dynamic attributes;
  final dynamic parameters;
  final dynamic action;
  final dynamic error;
  final ChassisPayload payload;

  ChassisItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        viewType = json['viewType'],
        attributes = json['attributes'],
        parameters = json['parameters'],
        action = json['action'],
        error = json['error'],
        payload = ChassisPayload.fromJson(json['payload']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'viewType': viewType,
      'attributes': attributes,
      'parameters': parameters,
      'action': action,
      if (error != null) 'error': error,
      'payload': payload.toJson(),
    };
  }
}
