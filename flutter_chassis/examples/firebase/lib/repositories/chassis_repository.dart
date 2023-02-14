/// Darts
import 'dart:async';
import 'dart:convert';

/// Packages
import 'package:http/http.dart' show Client;
import 'package:flutter_chassis/flutter_chassis.dart';

/// Local Files
import '../utils/readability.dart';

abstract class IChassisRepository {
  Future<dynamic> getData();
}

class ChassisRepository implements IChassisRepository {
  @override
  Future<Iterable<ChassisItem>> getData() async {
    return Readability.readFrom('assets/source.json').then((data) {
      final items = data['items'] as List<dynamic>?;
      if (items == null) {
        throw UnsupportedError('Invalid data: $data -> "items" is missing');
      }
      return items.map((e) => ChassisItem.fromJson(e));
    });
  }
}
