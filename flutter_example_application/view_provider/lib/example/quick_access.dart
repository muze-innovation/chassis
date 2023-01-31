import 'package:flutter/material.dart';

class QuickAccess extends StatefulWidget {
  const QuickAccess(this.stream, this.config, {super.key});

  final Stream stream;
  final Map<String, dynamic> config;

  @override
  State<QuickAccess> createState() => _QuickAccessState();
}

class _QuickAccessState extends State<QuickAccess> {
  @override
  Widget build(BuildContext context) {
    var attrs = widget.config['attributes'];
    var params = widget.config['parameters'];
    var payload = widget.config['payload'];
    return StreamBuilder(
      stream: widget.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return SizedBox(
            height: 200,
            child: Center(
              child: Text(
                'Error, please try again later!',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          );
        } else {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const SizedBox(
                height: 200,
                child: Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              var items = snapshot.data['item'] as List;
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
                  SizedBox(
                    height: double.parse(attrs['heightValue'] as String),
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(16),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return _listItem(items[index]);
                      },
                      separatorBuilder: (context, index) {
                        return const Padding(padding: EdgeInsets.all(8));
                      },
                      itemCount: items.length,
                    ),
                  )
                ],
              );
          }
        }
      },
    );
  }

  Widget _listItem(dynamic item) {
    return SizedBox(
      width: 100,
      height: 50,
      child: InkWell(
        onTap: _showAlertDialog,
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: Material(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                elevation: 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(item['asset']),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(4)),
            Center(
              child: Text(
                item['title'],
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ],
        ),
      ),
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
