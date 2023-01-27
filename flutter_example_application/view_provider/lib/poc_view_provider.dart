import 'package:flutter/material.dart';

abstract class IViewProvider {
  Map<String, IWidget> get viewMapper;
  IWidget? getView(String viewType, Map<String, dynamic> config);
}

abstract class IWidget {
  set config(Map<String, dynamic> config);
}

class ExampleViewProvider implements IViewProvider {
  @override
  Map<String, IWidget> get viewMapper => {
        'banner': BannerWidget(),
      };

  @override
  IWidget? getView(String viewType, Map<String, dynamic> config) {
    var widget = viewMapper[viewType];
    if (widget != null) {
      widget.config = config;
    }
    return widget;
  }
}

class BannerWidget extends StatelessWidget implements IWidget {
  BannerWidget({super.key});

  late Map<String, dynamic> _config;

  @override
  set config(config) {
    _config = config;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Condig ${_config['attrs']}'),
    );
  }
}
