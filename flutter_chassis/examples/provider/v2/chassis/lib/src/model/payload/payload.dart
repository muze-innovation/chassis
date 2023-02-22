enum PayloadType {
  static,
  remote,
}

class Payload {
  Payload({required this.type, this.data, this.resolvedWith, this.input});

  final PayloadType type;

  /// `static` type will has data
  final dynamic data;

  /// `remote` type will has resolvedWith and input
  final String? resolvedWith;
  final dynamic input;

  Payload.fromJson(Map<String, dynamic> json)
      : type = PayloadType.values.byName(json['type']),
        data = json['data'],
        resolvedWith = json['resolvedWith'],
        input = json['input'];

  Map<String, dynamic> toJson() {
    return {
      'type': type.name,
      'data': data,
      'resolvedWith': resolvedWith,
      'input': input
    };
  }
}
