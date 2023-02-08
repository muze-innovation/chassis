import 'dart:async';

import 'package:data_provider/model/banner_input.dart';

import '../model/quick_access_item_output.dart';
import '../repository/product_repository.dart';

abstract class IQuickAccessItemDataProvider {
  Stream<QuickAccessItemOutput> getData();
  // void getData(StreamController<dynamic> controller);
  //  void dispose();
}

class QuickAccessItemDataProvider implements IQuickAccessItemDataProvider {
  final _productRepository = ProductRepository();
  // late StreamSubscription<dynamic>? _streamSubscription;
  @override
  Stream<QuickAccessItemOutput> getData() {
    // _streamSubscription =
    //     _productRepository.streamProductReccomend().listen((event) {
    //   controller.add(QuickAccessItemOutput.fromJson(event.data()).toJson());
    // });
    return _productRepository
        .streamProductReccomend()
        .map((event) => QuickAccessItemOutput.fromJson(event.data()));
  }

  // @override
  // void dispose() {
  //   print("QuickAccessItemDataProvider dispose");
  //   _streamSubscription?.cancel();
  // }
}
