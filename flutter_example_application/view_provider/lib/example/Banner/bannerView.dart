import 'package:flutter/material.dart';

import 'bannerModel.dart';

class BannerView extends StatefulWidget {
  final Stream<BannerItem> stream;
  final BannerModel model;

  const BannerView({Key? key, required this.stream, required this.model})
      : super(key: key);

  @override
  State<BannerView> createState() => _BannerState();
}

class _BannerState extends State<BannerView> {
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
      initialData: model.payload.data,
      stream: widget.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        if (snapshot.hasData) {
          return BannerMainView(snapshot.data!, model.attributes);
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return BannerLoadingView(model.attributes);
          case ConnectionState.done:
          case ConnectionState.active:
            return BannerMainView(snapshot.data!, model.attributes);
          default:
            return Container();
        }
      },
    );
  }
}

Widget BannerLoadingView(BannerAttributes attrs) {
  return AspectRatio(
      aspectRatio: getRatio(attrs.heightValue),
      child: Container(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.0)),
          )));
}

double getRatio(String raio) {
  var value = raio.split(':');
  return double.parse(value[0]) / double.parse(value[1]);
}

Widget BannerMainView(BannerItem item, BannerAttributes attrs) {
  return AspectRatio(
      aspectRatio: getRatio(attrs.heightValue),
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
