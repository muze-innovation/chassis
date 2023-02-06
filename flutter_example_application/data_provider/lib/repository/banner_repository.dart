import 'dart:convert';

import 'package:http/http.dart';

abstract class IBannerRepository {
  Future<Map<String, dynamic>> getData(String slug);
}

class BannerRepository implements IBannerRepository {
  Client client = Client();

  static const String _baseUrl =
      'https://00b802ba-b85b-4531-ad60-1ad30116d1cd.mock.pstmn.io';

  @override
  Future<Map<String, dynamic>> getData(String slug) async {
    final url = Uri.parse('$_baseUrl/banner').replace(queryParameters: {
      'slug': slug,
    });
    final response = await client.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      // throw Exception('Failed to load Chassis API');
      return {
        "asset":
            "https://firebasestorage.googleapis.com/v0/b/nattariit.appspot.com/o/banner%2Fpizza_4_1.png?alt=media&token=bb399238-8c46-4081-b472-5f6725c587ea",
        "placeholder":
            "https://firebasestorage.googleapis.com/v0/b/nattariit.appspot.com/o/banner%2Fplace_holder.png?alt=media&token=52ae3f33-ab3f-4118-82b3-0a86b4708ba9"
      };
    }
  }
}
