import 'dart:convert';

import 'package:http/http.dart';

abstract class IProductRepository {
  Future<Map<String, dynamic>> getProcutReccomend();
}

class ProductRepository implements IProductRepository {
  Client client = Client();

  static const String _baseUrl =
      'https://00b802ba-b85b-4531-ad60-1ad30116d1cd.mock.pstmn.io';

  @override
  Future<Map<String, dynamic>> getProcutReccomend() async {
    final url = Uri.parse('$_baseUrl/product/Recommend');
    final response = await client.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load Chassis API');
    }
  }
}
