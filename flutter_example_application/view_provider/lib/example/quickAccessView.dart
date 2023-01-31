import 'dart:developer';
import 'package:flutter/material.dart';

class QuickAccessView extends StatefulWidget {
  final Stream stream;
  final Map<String, dynamic> config;

  const QuickAccessView({Key? key, required this.stream, required this.config})
      : super(key: key);

  @override
  State<QuickAccessView> createState() => _QuickAccessState();
}

class _QuickAccessState extends State<QuickAccessView> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log(widget.config.toString(), name: 'QuickAccess - Build');
    List<QuickAccessItem> payload = [];
    var params = widget.config['parameters'];

    return StreamBuilder<dynamic>(
      stream: widget.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        if (snapshot.data != null) {
          List<dynamic> value = snapshot.data['item'];
          payload = List<QuickAccessItem>.from(value.map((model) {
            return QuickAccessItem(
              title: model['title'],
              asset: model['asset'],
            );
          }));
        }

        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return _quickAccessLoadingView();
          case ConnectionState.done:
          case ConnectionState.active:
            log(payload.toString(), name: 'QuickAccess snapshot');
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          params['title'],
                          style: Theme.of(context).textTheme.headlineSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: _showAlertDialog,
                        icon: const Icon(Icons.arrow_circle_right_outlined),
                      ),
                    ],
                  ),
                ),
                _quickAccessMainView(payload),
              ],
            );
        }
      },
    );
  }

  Widget _quickAccessMainView(List<QuickAccessItem> payload) {
    return SizedBox(
      height: 140,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        separatorBuilder: (context, index) {
          return const Padding(padding: EdgeInsets.all(8));
        },
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: payload.length,
        itemBuilder: (context, index) {
          return _listItem(payload[index]);
        },
      ),
    );
  }

  Widget _listItem(QuickAccessItem item) {
    return SizedBox(
      width: 80,
      child: InkWell(
        onTap: _showAlertDialog,
        child: Column(
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: Material(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                elevation: 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(item.asset),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(4)),
            Center(
              child: Text(
                item.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _quickAccessLoadingView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Container(
            width: 300,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        SizedBox(
          height: 140,
          width: double.infinity,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return _loadingItem();
            },
            itemCount: 5,
            separatorBuilder: (BuildContext context, int index) {
              return const Padding(padding: EdgeInsets.all(8));
            },
          ),
        ),
      ],
    );
  }

  Widget _loadingItem() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        const SizedBox(
          width: 80,
          height: 8,
        ),
        Container(
          width: 80,
          height: 10,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        const SizedBox(
          width: 80,
          height: 2,
        ),
        Container(
          width: 80,
          height: 10,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ],
    );
  }

  void _showAlertDialog() {
    Widget closeBtn = TextButton(
      child: const Text("Close"),
      onPressed: () => Navigator.of(context).pop(),
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Sorry"),
      content: const Text("This feature is not available."),
      actions: [
        closeBtn,
      ],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
    );
    showDialog(context: context, builder: (context) => alert);
  }
}

class QuickAccessItem {
  final String title;
  final String asset;
  const QuickAccessItem({required this.title, required this.asset});
}
