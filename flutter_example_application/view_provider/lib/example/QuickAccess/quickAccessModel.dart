import 'dart:math';

class QuickAccessModel {
  String id;
  String viewType;
  QuickAccessAttributes attributes;
  QuickAccessParameters parameters;
  QuickAccessPayload payload;
  String? placeholder;
  QuickAccessModel(
      {required this.id,
      required this.viewType,
      required this.attributes,
      required this.parameters,
      required this.payload,
      this.placeholder});

  QuickAccessModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        viewType = json['viewType'],
        attributes = QuickAccessAttributes.fromJson(json['attributes']),
        parameters = QuickAccessParameters.fromJson(json['parameters']),
        payload = QuickAccessPayload.fromJson(json['payload']),
        placeholder = json['placeholder'];
}

class QuickAccessAttributes {
  String heightPolicy;
  int heightValue;
  String? color;
  QuickAccessAttributes(
      {required this.heightPolicy, required this.heightValue, this.color});

  QuickAccessAttributes.fromJson(Map<String, dynamic> json)
      : heightPolicy = json['heightPolicy'],
        heightValue = json['heightValue'],
        color = json['color'];
}

class QuickAccessParameters {
  String title;
  QuickAccessParameters({this.title = ""});

  QuickAccessParameters.fromJson(Map<String, dynamic> json)
      : title = json['title'];
}

class QuickAccessPayload {
  String type;
  QuickAccessPayloadData? data;
  QuickAccessPayload({required this.type, this.data});

  QuickAccessPayload.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        data = json['data'] != null
            ? QuickAccessPayloadData.fromJson(json['data'])
            : null;
}

class QuickAccessPayloadData {
  List<QuickAccessItem>? item;
  QuickAccessPayloadData.fromJson(Map<String, dynamic> json)
      : item = List<QuickAccessItem>.from((json['item']).map((x) {
          return QuickAccessItem.fromJson(x);
        }));
}

class QuickAccessItem {
  String title;
  String asset;

  QuickAccessItem.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        asset = json['asset'];
}
