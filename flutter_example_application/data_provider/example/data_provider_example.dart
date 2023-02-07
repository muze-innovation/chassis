import 'dart:async';

import 'package:data_provider/core.dart';

void main() {
  // final dataProvider = DataProvider();
  final controller = StreamController<Map<String, dynamic>>.broadcast();
  final payload = {
    "resolvedWith": "GetQuickAccessItem",
    // "input": {"slug": "best_seller"}
  };
  controller.stream.listen(
    (value) {
      print('StreamController get value : $value');
    },
    onDone: () {
      print('main onDone');
    },
    onError: (e) {
      print('error is $e');
    },
    cancelOnError: false,
  );
  // dataProvider.getData(controller, payload);
}
