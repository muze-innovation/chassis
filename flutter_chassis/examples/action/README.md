# Action

Action of each section can be handled in many ways according to user's preferences. In this example we used delegate pattern to handle actions.

## Json file
```json
"action": {
    "type": "",
    "url": ""
}
```

- Type: action's type.
- Url: url or page route of the destination.

`Note: this is subject to changed.`


## Handle actions
Creating a mixin for delegator.
```dart
mixin ActionDelegate {
  void onAction(BuildContext context, Map<String, dynamic> config,
      Map<String, dynamic>? data);
}
```

Creating a class for handling actions.
```dart
class ActionManager {
  String type = '';
  String url = '';

  ActionManager({required this.type, required this.url});

  ActionManager.fromJson(Map<String, dynamic>? json) {
    type = json?["type"] ?? '';
    url = json?["url"] ?? '';
  }

  void execute(BuildContext context, Map<String, dynamic>? data) async =>
      _execute(context, data);

  void _execute(BuildContext context, Map<String, dynamic>? data) {
    switch (type) {
      case 'navigate':
        return _navigate(context);
      case 'route':
        return _goToRoute(context, data);
      default:
        throw Exception('Action not supported');
    }
  }

  void _navigate(BuildContext context) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  void _goToRoute(BuildContext context, Map<String, dynamic>? data) async {
    if (url == ActionUrl.back) {
      Navigator.pop(context);
    } else if (url == ActionUrl.backToHome) {
      Navigator.popUntil(context, (route) => route.isFirst);
    } else {
      Navigator.pushNamed(context, url, arguments: data);
    }
  }
}
```

Implementing mixin in our screen.
```dart
class _FoodLandingScreenState extends State<FoodLandingScreen> implements ActionDelegate {
    void setupChassis() async {
   ...
    final viewProvider = AppViewProvider(delegate: _FoodLandingScreenState());
    _chassis = Chassis(
        dataProvider: dataProvider,
        viewProvider: viewProvider
    );
    ...
  }
  
  @override
  void onAction(BuildContext context, Map<String, dynamic> config, Map<String, dynamic>? data) {
    ActionManager manager = ActionManager.fromJson(config);
    manager.execute(context, data);
  }
}
```

Then in ViewProvider, we can pass the delegate instance to widgets.
```dart
class AppViewProvider extends BaseViewProvider {
  // Can pass action delegator here if needed.
  final ActionDelegate delegate;
  AppViewProvider({required this.delegate});

  // Return any types of widget. It doesn't have to be inherited widget.
  @override
  Widget getBannerView(Stream<BannerItem> stream, BannerModel model) {
    return InheritedBanner(
        stream: stream, model: model, delegate: delegate, child: BannerView());
  }
}
```

Finally, we can call delegate.onAction() when user performs the desired action.

