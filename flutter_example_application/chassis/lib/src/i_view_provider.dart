import 'dart:async';

abstract class IViewProvider {
  void getView(Stream<dynamic> stream, Map<String, dynamic> config);
}
