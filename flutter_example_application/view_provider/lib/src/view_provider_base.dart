/// Foundation
import 'package:flutter/widgets.dart';

/// Chassis
import 'package:chassis/view_provider.dart';

class ViewProvider implements IViewProvider {
  @override
  Widget getView(Stream<dynamic> stream, ChassisItem item) {
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
