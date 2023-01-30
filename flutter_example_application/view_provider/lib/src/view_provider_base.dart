import 'package:chassis/interface.dart';
import 'package:flutter/widgets.dart';

class ViewProvider implements IViewProvider {
  @override
  Widget getView(Stream<dynamic> stream, Map<String, dynamic> config) {
    return StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
          }
          print('snapshot.connectionState: ${snapshot.connectionState}');
          print('snapshot.data: ${snapshot.data}');
          print('snapshot.error: ${snapshot.error}');
          return const Text('data');
        });
  }
}
