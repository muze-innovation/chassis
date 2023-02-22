import 'package:flutter/widgets.dart';

import '../../model/item/item.dart';

abstract class ViewResolverBase {
  Map<String, ViewResolverBase> routeTable = {};

  Widget? getView(Stream<dynamic> stream, Item item) {
    print('No view found');
    return Container();
  }
}
