import 'package:chassis/models/chassis_item.dart';

class ChassisModel {
  const ChassisModel({
    required this.id,
    required this.viewType,
    this.attributes,
    this.parameters,
    this.action,
    this.error,
  });

  final String id;
  final String viewType;
  final Attributes? attributes;
  final Parameters? parameters;
  final ChassisAction? action;
  final Error? error;

  factory ChassisModel.fromChassisItem(ChassisItem item) => ChassisModel(
      id: item.id,
      viewType: item.viewType,
      attributes:
          item.attributes == null ? null : Attributes.fromJson(item.attributes),
      parameters:
          item.parameters == null ? null : Parameters.fromJson(item.parameters),
      action: item.action == null ? null : ChassisAction.fromJson(item.action),
      error: item.error == null ? null : Error.fromJson(item.error));
}

class ChassisAction {
  ChassisAction({
    this.type,
    this.url,
  });

  final String? type;
  final String? url;

  factory ChassisAction.fromJson(Map<String, dynamic> json) => ChassisAction(
        type: json["type"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "url": url,
      };
}

class Attributes {
  Attributes({
    this.heightPolicy,
    this.heightValue,
    this.color,
  });

  final String? heightPolicy;
  final dynamic heightValue;
  final String? color;

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        heightPolicy: json["heightPolicy"],
        heightValue: json["heightValue"],
        color: json["color"],
      );
}

class Error {
  Error({
    this.errorType,
  });

  final String? errorType;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        errorType: json["errorType"],
      );
}

class Parameters {
  Parameters({
    this.title,
  });

  final String? title;

  factory Parameters.fromJson(Map<String, dynamic> json) => Parameters(
        title: json["title"],
      );
}

class PayloadData {
  PayloadData({
    this.items = const [],
    this.asset,
    this.placeholder,
  });

  final List<Item> items;
  final String? asset;
  final String? placeholder;

  factory PayloadData.fromJson(Map<String, dynamic> json) => PayloadData(
        items: json["item"] == null
            ? []
            : List<Item>.from(json["item"]!.map((x) => Item.fromJson(x))),
        asset: json["asset"],
        placeholder: json["placeholder"],
      );
}

class Item {
  Item({
    this.asset,
    this.title,
  });

  final String? asset;
  final String? title;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        asset: json["asset"],
        title: json["title"],
      );
}
