import 'package:flutter_chassis/models/chassis_payload.dart';

class ChassisItem {
  ChassisItem(
      {required this.id,
      required this.viewType,
      this.attributes,
      this.parameters,
      required this.payload});

  final String id;
  final String viewType;
  final dynamic attributes;
  final dynamic parameters;
  final ChassisPayload payload;

  ChassisItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        viewType = json['viewType'],
        attributes = json['attributes'],
        parameters = json['parameters'],
        payload = ChassisPayload.fromJson(json['payload']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'viewType': viewType,
      'attributes': attributes,
      'parameters': parameters,
      'payload': payload.toJson(),
    };
  }
}
