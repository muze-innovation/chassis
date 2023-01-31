import 'dart:developer';

import 'package:chassis/interface.dart';
import 'package:flutter/widgets.dart';
import 'package:view_provider/example/bannerView.dart';
import 'package:view_provider/example/quickAccessView.dart';

class ViewProvider implements IViewProvider {
  @override
  Widget? getView(Stream<dynamic> stream, Map<String, dynamic> config) {
    var viewType = config['viewType'];
    log(viewType, name: 'viewType');

    Map<String, Widget?> views = {
      'Banner': getBannerView(stream, config),
      'QuickAccess': getQuickAccessView(stream, config)
    };

    return views[viewType];
  }

  Widget? getBannerView(Stream<dynamic> stream, Map<String, dynamic> config) {
    return BannerView(stream: stream, config: config);
  }

  Widget? getQuickAccessView(
      Stream<dynamic> stream, Map<String, dynamic> config) {
    return QuickAccessView(stream: stream, config: config);
  }
}
