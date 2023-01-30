import 'dart:async';
import 'package:flutter/widgets.dart';

abstract class IViewProvider {
  Widget getView(Stream<dynamic> stream, Map<String, dynamic> config);
}
