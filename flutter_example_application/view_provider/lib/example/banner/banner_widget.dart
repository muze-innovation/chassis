import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:view_provider/action/action.dart';
import 'banner_model.dart';

class BannerWidget extends StatefulWidget {
  final Stream<BannerItem> stream;
  final BannerModel model;
  final IAction delegate;

  const BannerWidget(
      {Key? key,
      required this.stream,
      required this.model,
      required this.delegate})
      : super(key: key);

  @override
  State<BannerWidget> createState() => _BannerState();
}

class _BannerState extends State<BannerWidget> {
  _BannerState();

  @override
  void dispose() {
    super.dispose();
    // TODO: stop listening to stream?
  }

  @override
  Widget build(BuildContext context) {
    BannerModel model = widget.model;
    return StreamBuilder<BannerItem>(
      stream: widget.stream,
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
                  model.action, widget.delegate, context);
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
      IAction delegate,
      BuildContext context) {
    print('Banner action: ${actionConfig}');
    return AspectRatio(
      aspectRatio: _getRatio(attrs.heightValue),
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        width: double.infinity,
        child: Center(
          child: GestureDetector(
            onTap: () => actionConfig != null
                ? delegate.onAction(context, actionConfig, null)
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

class InheritedBanner extends InheritedWidget {
  final Stream<BannerItem> stream;
  final BannerModel model;
  final IAction delegate;

  final Widget child;

  InheritedBanner(
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
    return delegate != oldWidget.delegate;
  }
}

class InheritedBannerDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = InheritedBanner.of(context)!;
    BannerModel model = state.model;
    return StreamBuilder<BannerItem>(
      stream: state.stream,
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
                  model.action, state.delegate, context);
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
      IAction delegate,
      BuildContext context) {
    return AspectRatio(
      aspectRatio: _getRatio(attrs.heightValue),
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        width: double.infinity,
        child: Center(
          child: GestureDetector(
            onTap: () => actionConfig != null
                ? delegate.onAction(context, actionConfig, null)
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
