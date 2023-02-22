import '../payload/payload.dart';

class Item {
  Item(
      {required this.id,
      required this.viewType,
      this.attributes,
      this.parameters,
      this.action,
      required this.payload});

  final String id;
  final String viewType;
  final dynamic attributes;
  final dynamic parameters;
  final dynamic action;
  final Payload payload;

  Item.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        viewType = json['viewType'],
        attributes = json['attributes'],
        parameters = json['parameters'],
        action = json['action'],
        payload = Payload.fromJson(json['payload']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'viewType': viewType,
      'attributes': attributes,
      'parameters': parameters,
      'action': action,
      'payload': payload.toJson(),
    };
  }
}
