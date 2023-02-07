import 'package:flutter/widgets.dart';

abstract class ChassisWidget extends Widget {
  const ChassisWidget(this.stream, this.config, {super.key});

  final Stream<dynamic> stream;
  final Map<String, dynamic> config;

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

  // Empty state
  @protected
  Widget empty(BuildContext context);
}

class ChassisElement extends ComponentElement {
  ChassisElement(ChassisWidget super.widget);

  @override
  Widget build() {
    var chassisWidget = (widget as ChassisWidget);
    return StreamBuilder(
      stream: chassisWidget.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return chassisWidget.error(this);
        }
        if (snapshot.hasData) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return chassisWidget.empty(this);
            case ConnectionState.waiting:
              return chassisWidget.loading(this);
            case ConnectionState.active:
            case ConnectionState.done:
              return chassisWidget.success(this, snapshot.data);
          }
        }
        return chassisWidget.loading(this);
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
