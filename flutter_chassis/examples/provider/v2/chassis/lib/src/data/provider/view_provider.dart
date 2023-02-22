import 'dart:async';

import 'package:flutter/widgets.dart';
import '../../model/item/item.dart';

abstract class ViewProviderBase {
  Widget? getView(Stream<dynamic> stream, Item item);
}
