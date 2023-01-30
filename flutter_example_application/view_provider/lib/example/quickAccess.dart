import 'package:flutter/material.dart';

class QuickAccess extends StatefulWidget {
  final Stream stream;
  final Map<String, dynamic> config;

  const QuickAccess({Key? key, required this.stream, required this.config})
      : super(key: key);

  @override
  State<QuickAccess> createState() => _QuickAccessState();
}

class _QuickAccessState extends State<QuickAccess> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('QuickAccess - Build ${widget.config}');
    List<QuickAccessItem> payload = [];

    return StreamBuilder<dynamic>(
      stream: widget.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        if (snapshot.data != null) {
          List<dynamic> value = snapshot.data['item'];
          payload = List<QuickAccessItem>.from(value.map((model) =>
              QuickAccessItem(title: model['title'], asset: model['asset'])));
        }

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return QuickAccessLoadingView();
          case ConnectionState.done:
          case ConnectionState.active:
            print('QuickAccess snapshot: ${payload}');
            return QuickAccessMainView(payload);
          default:
            return Container();
        }
      },
    );
  }
}

class QuickAccessItem {
  String title;
  String asset;
  QuickAccessItem({required this.title, required this.asset});
}

Widget QuickAccessLoadingView() {
  return Container(
      height: 140,
      width: double.infinity,
      child: Row(
        children: [
          LoadingItem(),
          LoadingItem(),
          LoadingItem(),
          LoadingItem(),
          LoadingItem()
        ],
      ));
}

Widget LoadingItem() {
  return Container(
    padding: EdgeInsets.all(8),
    child: Column(
      children: [
        Container(
          width: 62,
          height: 62,
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16)),
        ),
        const SizedBox(
          width: 62,
          height: 8,
        ),
        Container(
          width: 62,
          height: 10,
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16)),
        ),
        const SizedBox(
          width: 62,
          height: 2,
        ),
        Container(
          width: 62,
          height: 10,
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16)),
        ),
      ],
    ),
  );
}

Widget QuickAccessMainView(List<QuickAccessItem> payload) {
  return Container(
    height: 140,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: payload.map((item) {
        return Column(
          children: [
            Container(
              width: 80,
              height: 80,
              padding: EdgeInsets.all(8),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child:
                      Image.network(item.asset, fit: BoxFit.cover, width: 80)),
            ),
            Container(
              width: 80,
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Text(
                item.title,
                maxLines: 2,
              ),
            )
          ],
        );
      }).toList(),
    ),
  );
}
