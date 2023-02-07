import 'dart:convert';

import 'package:http/http.dart';

abstract class IBannerRepository {
  Future<Map<String, dynamic>> getData(String slug);
}

class BannerRepository implements IBannerRepository {
  Client client = Client();

  static const String _baseUrl =
      'https://152e3105-2193-472e-968c-55eb9b131f37.mock.pstmn.io';

  @override
  Future<Map<String, dynamic>> getData(String slug) async {
    final url = Uri.parse('$_baseUrl/banner').replace(queryParameters: {
      'slug': slug,
    });
    final response = await client.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load Chassis API');
    }
  }
}
