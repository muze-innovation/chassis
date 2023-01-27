import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' show Client;

abstract class IChassisRepository {
  Future<Map<String, dynamic>> getData();
}

class ChassisRepository implements IChassisRepository {
  Client client = Client();

  static const String _baseUrl =
      'https://3f65e6d1-ab4c-44ae-a469-d4ca7553ccd3.mock.pstmn.io';

  Future<Map<String, dynamic>> getData() async {
    final url = Uri.parse('$_baseUrl/chassis');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load Chassis API');
    }
  }
}
