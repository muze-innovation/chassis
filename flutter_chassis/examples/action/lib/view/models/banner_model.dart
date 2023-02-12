class BannerModel {
  String id;
  String viewType;
  BannerAttributes attributes;
  Map<String, dynamic>? action;
  BannerModel(
      {required this.id,
      required this.viewType,
      required this.attributes,
      this.action});

  BannerModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        viewType = json['viewType'],
        attributes = BannerAttributes.fromJson(json['attributes']),
        action = json['action'];
}

class BannerAttributes {
  String heightPolicy;
  String heightValue;
  String? color;
  BannerAttributes(
      {required this.heightPolicy, required this.heightValue, this.color});

  BannerAttributes.fromJson(Map<String, dynamic> json)
      : heightPolicy = json['heightPolicy'],
        heightValue = json['heightValue'],
        color = json['color'];
}

class BannerPayload {
  String? type;
  BannerItem? data;
  BannerPayload({this.type, this.data});

  BannerPayload.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        data = json['data'] != null ? BannerItem.fromJson(json['data']) : null;
}

class BannerItem {
  String asset;
  String? placeholder;
  BannerItem({required this.asset, this.placeholder});

  BannerItem.fromJson(Map<String, dynamic> json)
      : asset = json['asset'],
        placeholder = json['placeholder'];
}
