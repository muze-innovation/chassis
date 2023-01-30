library view_provider;

import 'package:chassis/chassis.dart';
import 'package:flutter/material.dart';

class ExampleViewProvider implements IViewProvider {
  @override
  Widget? getView(Stream stream, Map<String, dynamic> config) {
    var viewType = config['viewType'];
    switch (viewType) {
      case 'ShelfContent':
        return null;
      case 'QuickAccess':
        return null;
      case 'Banner':
        return StreamBuilder(
          stream: stream,
          builder: ((context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              default:
                return Container();
            }
          }),
        );
      default:
        return null;
    }
  }
}
