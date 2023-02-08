import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class ISpecProvider {
  Future<Map<String, dynamic>> getSpec(String path);
}

class SpecProvider implements ISpecProvider {
  static final SpecProvider _instance = SpecProvider._();
  static SpecProvider get instance => _instance;

  SpecProvider._();

  final Map<String, Map<String, dynamic>> _holder = {};

  @override
  Future<Map<String, dynamic>> getSpec(String path) async {
    // final spec = _holder[path];
    // if (spec != null) {
    //   return spec;
    // }

    final String viewSpecJson = await rootBundle.loadString(path);
    final Map<String, dynamic> viewSpecMap = json.decode(viewSpecJson);
    _holder[path] = viewSpecMap;
    return viewSpecMap;
  }
}
