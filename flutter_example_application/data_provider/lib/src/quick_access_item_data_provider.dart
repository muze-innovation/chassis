import 'dart:async';

import '../repository/product_repository.dart';

abstract class IQuickAccessItemDataProvider {
  void getData(StreamController<dynamic> controller);
}

class QuickAccessItemDataProvider implements IQuickAccessItemDataProvider {
  final _productRepository = ProductRepository();
  late StreamSubscription<dynamic> _streamSubscription;
  @override
  void getData(StreamController<dynamic> controller) {
    controller.stream.listen(
      (value) {
        print('StreamController get value : $value');
      },
      onDone: () {
        print('StreamController onDone');
        closeSubscription();
      },
      onError: (e) {
        print('StreamController error is $e');
      },
      cancelOnError: false,
    );
    _streamSubscription = _productRepository.streamProductReccomend().listen(
      (value) {
        print('streamProductReccomend value: ${value.data()}');
        controller.add(value);
      },
      onDone: () {
        print('streamProductReccomend onDone');
      },
      onError: (e) {
        print('streamProductReccomend error is $e');
      },
    );
  }

  void closeSubscription() {
    _streamSubscription.cancel();
  }
}
