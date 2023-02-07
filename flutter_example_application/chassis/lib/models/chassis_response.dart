import 'package:chassis/core.dart';

class ChassisResponse {
  ChassisResponse({required this.resolvedWith, this.output});

  final String resolvedWith;
  final dynamic output;

  ChassisResponse.fromJson(Map<String, dynamic> json)
      : resolvedWith = json['resolvedWith'],
        output = json['input'];

  Map<String, dynamic> toJson() {
    return {'resolvedWith': resolvedWith, 'input': output};
  }
}
