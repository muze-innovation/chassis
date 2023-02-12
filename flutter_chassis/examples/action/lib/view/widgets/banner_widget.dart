/// Packages
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Local Files
import '../models/banner_model.dart';
import '../../action/action.dart';

class InheritedBanner extends InheritedWidget {
  final Stream<BannerItem> stream;
  final BannerModel model;
  final ActionDelegate delegate;

  @override
  final Widget child;

  const InheritedBanner(
      {Key? key,
      required this.stream,
      required this.model,
      required this.delegate,
      required this.child})
      : super(key: key, child: child);

  static InheritedBanner? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<InheritedBanner>();

  @override
  bool updateShouldNotify(InheritedBanner oldWidget) {
    return model != oldWidget.model || delegate != oldWidget.delegate;
  }
}

class BannerView extends StatelessWidget {
  const BannerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final props = InheritedBanner.of(context)!;
    BannerModel model = props.model;
    return StreamBuilder<BannerItem>(
      stream: props.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return _bannerLoadingView(model.attributes);
          case ConnectionState.done:
          case ConnectionState.active:
            if (snapshot.hasData) {
              return _bannerMainView(snapshot.data!, model.attributes,
                  model.action, props.delegate, context);
            } else {
              return Container();
            }
          default:
            return Container();
        }
      },
    );
  }

  Widget _bannerLoadingView(BannerAttributes attrs) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade900,
      highlightColor: Colors.grey.shade100,
      child: AspectRatio(
        aspectRatio: _getRatio(attrs.heightValue),
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ),
    );
  }

  double _getRatio(String raio) {
    var value = raio.split(':');
    return double.parse(value[0]) / double.parse(value[1]);
  }

  Widget _bannerMainView(
      BannerItem item,
      BannerAttributes attrs,
      Map<String, dynamic>? actionConfig,
      ActionDelegate delegate,
      BuildContext context) {
    return AspectRatio(
      aspectRatio: _getRatio(attrs.heightValue),
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        width: double.infinity,
        child: Center(
          child: GestureDetector(
            onTap: () => actionConfig != null
                ? delegate.onAction(
                    context, actionConfig, null) // Call delegate.onAction here
                : null,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                item.asset,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Text('Cannot display an image'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
