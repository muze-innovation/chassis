import 'package:chassis/interface.dart';
import 'package:flutter/widgets.dart';
import 'package:view_provider/example/banner.dart' as custom;

// class ViewProvider implements IViewProvider {
//   @override
//   Widget getView(Stream<dynamic> stream, Map<String, dynamic> config) {
//     return StreamBuilder(
//         stream: stream,
//         builder: (context, snapshot) {
//           switch (snapshot.connectionState) {
//           }
//           print('snapshot.connectionState: ${snapshot.connectionState}');
//           print('snapshot.data: ${snapshot.data}');
//           print('snapshot.error: ${snapshot.error}');
//           return const Text('data');
//         });
//   }
// }

class ViewProvider implements IViewProvider {
  @override
  Widget? getView(Stream<dynamic> stream, Map<String, dynamic> config) {
    var viewType = config['viewType'];
    print('ViewProvider: $viewType');
    switch (viewType) {
      case 'Banner':
        return custom.Banner(stream: stream, config: config);
      default:
        return null;
    }
  }
}
