class ChassisRequest {
  ChassisRequest({required this.resolvedWith, this.input});

  /// `remote` type will has resolvedWith and input
  final String resolvedWith;
  final dynamic input;

  ChassisRequest.fromJson(Map<String, dynamic> json)
      : resolvedWith = json['resolvedWith'],
        input = json['input'];

  Map<String, dynamic> toJson() {
    return {'resolvedWith': resolvedWith, 'input': input};
  }
}
