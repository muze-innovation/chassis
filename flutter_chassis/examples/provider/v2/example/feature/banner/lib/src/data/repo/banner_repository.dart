import 'dart:convert';

import 'package:banner/src/model/banner.dart';
import 'package:http/http.dart';

abstract class BannerRepository {
  Future<Banner> getBanner(String slug);
}

class BannerRepositoryImpl implements BannerRepository {
  Client client = Client();

  static const String _baseUrl =
      'https://00b802ba-b85b-4531-ad60-1ad30116d1cd.mock.pstmn.io';

  @override
  Future<Banner> getBanner(String slug) async {
    final url = Uri.parse('$_baseUrl/banner').replace(queryParameters: {
      'slug': slug,
    });
    final response = await client.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = jsonDecode(response.body);
      return Banner(
          asset: jsonMap['asset'], placeholder: jsonMap['placeholder']);
    } else {
      throw Exception('Failed to load Chassis API');
    }
  }
}
