import 'dart:async';

import 'package:data_provider/data_provider.dart';
import 'package:data_provider/src/constant.dart';

void main() {
  final dataProvider = DataProvider();
  final controller = StreamController<Map<String, dynamic>>.broadcast();
  final payload = {resolvedWith: getBanner};
  controller.stream.listen(
    (value) {
      print('StreamController get value asset: ${value["asset"]}');
    },
    onDone: () {
      print('main onDone');
    },
    onError: (e) {
      print('error is $e');
    },
    cancelOnError: false,
  );
  dataProvider.getData(controller, payload);
}
