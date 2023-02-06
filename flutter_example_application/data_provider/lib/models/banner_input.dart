import 'package:chassis/data_provider.dart';

class BannerInput {
  BannerInput({required this.slug});

  final String slug;

  BannerInput.fromRequest(ChassisRequest request)
      : slug = request.input['slug'];

  Map<String, dynamic> toJson() {
    return {'slug': slug};
  }
}
