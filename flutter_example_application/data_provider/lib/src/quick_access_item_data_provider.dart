import 'dart:async';

import 'package:data_provider/model/banner_input.dart';

import '../model/quick_access_item_output.dart';
import '../repository/product_repository.dart';

abstract class IQuickAccessItemDataProvider {
  Stream<QuickAccessItemOutput> getData();
}

class QuickAccessItemDataProvider implements IQuickAccessItemDataProvider {
  final _productRepository = ProductRepository();
  @override
  Stream<QuickAccessItemOutput> getData() {
    return _productRepository
        .streamProductReccomend()
        .map((event) => QuickAccessItemOutput.fromJson(event.data()));
  }
}
