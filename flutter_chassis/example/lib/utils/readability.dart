import 'dart:convert';
import 'package:flutter/services.dart';

class Readability {
  static Future<Map<String, dynamic>> readFrom(String path) async {
    final String spec = await rootBundle.loadString(path);
    final Map<String, dynamic> specMap = json.decode(spec);
    return specMap;
  }
}
