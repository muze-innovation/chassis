import 'package:flutter/widgets.dart';
import 'package:view_provider/src/chassis_model.dart';

abstract class ChassisWidget extends Widget {
  const ChassisWidget(this.stream, this.config, {super.key});

  final Stream<PayloadData> stream;
  final ChassisModel config;

  @override
  ChassisElement createElement() => ChassisElement(this);

  // Success state
  @protected
  Widget success(BuildContext context, dynamic data);

  // Loading state
  @protected
  Widget loading(BuildContext context);

  // Error state
  @protected
  Widget error(BuildContext context);
}

class ChassisElement extends ComponentElement {
  ChassisElement(ChassisWidget super.widget);

  @override
  Widget build() {
    var chassisWidget = widget as ChassisWidget;
    return StreamBuilder(
      stream: chassisWidget.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return chassisWidget.error(this);
        } else {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return chassisWidget.loading(this);
            case ConnectionState.active:
            case ConnectionState.done:
              return chassisWidget.success(this, snapshot.data);
          }
        }
      },
    );
  }

  @override
  void update(ChassisWidget newWidget) {
    super.update(newWidget);
    assert(widget == newWidget);
    rebuild();
  }
}
