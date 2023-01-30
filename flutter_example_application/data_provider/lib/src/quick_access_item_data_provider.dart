import 'dart:async';

import '../repository/product_repository.dart';

abstract class IQuickAccessItemDataProvider {
  void getData(StreamController<dynamic> controller) async {}
}

class QuickAccessItemDataProvider implements IQuickAccessItemDataProvider {
  final _productRepository = ProductRepository();
  @override
  void getData(StreamController<dynamic> controller) async {
    await _productRepository.getProcutReccomend().then(
        (Map<String, dynamic> value) {
      controller.add(value);
    }, onError: (e) {
      controller.addError(e);
    });
  }
}
