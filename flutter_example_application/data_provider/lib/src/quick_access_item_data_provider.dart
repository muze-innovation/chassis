import 'dart:async';

import '../model/quick_access_item_output.dart';
import '../repository/product_repository.dart';

abstract class IQuickAccessItemDataProvider {
  Stream<QuickAccessItemOutput> getData(StreamController<dynamic> controller);
  void dispose();
}

class QuickAccessItemDataProvider implements IQuickAccessItemDataProvider {
  final _productRepository = ProductRepository();
  late StreamSubscription<dynamic> _streamSubscription;
  @override
  Stream<QuickAccessItemOutput> getData(StreamController<dynamic> controller) {
    controller.stream.listen(
      (value) {
        // do someting ...
      },
      onDone: () {
        closeSubscription();
      },
      onError: (e) {
        closeSubscription();
      },
      cancelOnError: false,
    );

    final stream = _productRepository.streamProductReccomend();
    _streamSubscription = stream.listen((value) {});
    return stream.map((event) => QuickAccessItemOutput.fromJson(event.data()));
  }

  void closeSubscription() {
    _streamSubscription.cancel();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
  }
}
