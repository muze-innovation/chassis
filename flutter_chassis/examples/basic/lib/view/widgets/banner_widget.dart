/// Packages
import 'package:flutter/material.dart';

/// Local Files
import '../models/banner_model.dart';

class BannerView extends StatefulWidget {
  final Stream<BannerItem> stream;
  final BannerModel model;

  const BannerView({Key? key, required this.stream, required this.model})
      : super(key: key);

  @override
  State<BannerView> createState() => _BannerState();
}

class _BannerState extends State<BannerView> {
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
          case ConnectionState.none:
          case ConnectionState.waiting:
            return _getBannerLoadingView(model.attributes);
          case ConnectionState.done:
          case ConnectionState.active:
            return _getBannerMainView(snapshot.data!, model.attributes);
        }
      },
    );
  }

  /// Private Methods
  double _getRatio(String raio) {
    var value = raio.split(':');
    return double.parse(value[0]) / double.parse(value[1]);
  }

  Widget _getBannerLoadingView(BannerAttributes attrs) {
    return AspectRatio(
        aspectRatio: _getRatio(attrs.heightValue),
        child: Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.0)),
            )));
  }

  Widget _getBannerMainView(BannerItem item, BannerAttributes attrs) {
    return AspectRatio(
        aspectRatio: _getRatio(attrs.heightValue),
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          width: double.infinity,
          child: Center(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(item.asset,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Text('Cannot display an image')))),
        ));
  }
}
