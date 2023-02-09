/// Darts
import 'dart:async';
import 'dart:convert';

/// Packages
import 'package:http/http.dart' show Client;
import 'package:flutter_chassis/flutter_chassis.dart';

abstract class IChassisRepository {
  Future<dynamic> getData();
}

class ChassisRepository implements IChassisRepository {
  Client client = Client();

  static const String _baseUrl =
      'https://chassis-376410-default-rtdb.asia-southeast1.firebasedatabase.app';

  @override
  Future<Iterable<ChassisItem>> getData() async {
    final url = Uri.parse('$_baseUrl/chassis.json');
    final response = await client.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final items = data['items'] as List<dynamic>?;
      if (items == null) {
        throw UnsupportedError('Invalid data: $data -> "items" is missing');
      }
      return items.map((e) => ChassisItem.fromJson(e));
    } else {
      throw Exception('Failed to load Chassis API');
    }
  }
}
