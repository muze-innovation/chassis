import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Banner extends StatefulWidget {
  final Stream stream;
  final Map<String, dynamic> config;

  const Banner({Key? key, required this.stream, required this.config})
      : super(key: key);

  @override
  State<Banner> createState() => _BannerState();
}

class BannerItem {
  final String asset;
  final String? placeholder;

  BannerItem({required this.asset, this.placeholder});
}

class _BannerState extends State<Banner> {
  _BannerState();

//   final List<String> _items = [
//   'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
//   'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
//   'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
//   'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
//   'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
//   'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
// ];

  List<BannerItem> _items = [];

  @override
  void dispose() {
    super.dispose();
    // TODO: stop listening to stream?
  }

  @override
  Widget build(BuildContext context) {
    print('Banner - Build ${widget.config}');
    return StreamBuilder<dynamic>(
      stream: widget.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            print('Banner - loading');
            return BannerLoadingView();
          case ConnectionState.done:
          case ConnectionState.active:
            print(
                "Banner snapshot: ${snapshot.data} ${snapshot.data['asset']}");
            BannerItem bannerItem = BannerItem(
                asset: snapshot.data['asset'],
                placeholder: snapshot.data['placeholder']);
            _items.add(bannerItem);
            return CarouselSlider(
              options: CarouselOptions(),
              items: _items
                  .map((item) => Container(
                        child: Center(
                            child: Image.network(item.asset,
                                // placeholder: item.placeholder,
                                fit: BoxFit.cover,
                                width: 1000,
                                errorBuilder: (context, error, stackTrace) =>
                                    Text('Cannot display an image'))),
                      ))
                  .toList(),
            );
          default:
            return Container();
        }
      },
    );
  }
}

Widget BannerLoadingView() {
  return Container(
      padding: EdgeInsets.all(8),
      height: 120,
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16)),
      ));
}
