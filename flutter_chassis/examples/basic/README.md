# Basic Project

A `Basic` project is an example project to show you how to use the `Chassis` library.

# Getting Started

## Step 1: Making an instance of a Chassis

The easiest way to use this library. `Chassis` allow you to make instance with `DataProvider`, `ViewProvider`, and `SchemaValidator`

#### **There are 3 main parts of Chassis including**

>`Chassis Core` get view and data from providers, and validate data before sending it to the view.
<br />
>`Data Provide` allows you stream response and validate output form your server.
<br />
>`View Provider` manages and arranges view to show by the response from the server.

```dart
/*
  from `food_landing_screen.dart`

  Set up Chassis, you can see the code example
*/

// read spec from JsonSchema file.
final resolverSpec =
    await Readability.readFrom('assets/resolver_spec.json');
final viewSpec = await Readability.readFrom('assets/view_spec.json');

// make the dataProvider, viewProvider, and schemaValidator
final schemaValidator =
    SchemaValidator(resolverSpec: resolverSpec, viewSpec: viewSpec);
final dataProvider = AppDataProvider();
final viewProvider = AppViewProvider();

// create instance
_chassis = Chassis(
    dataProvider: dataProvider,
    viewProvider: viewProvider,
    schemaValidator: schemaValidator);
```
<br />

## Step 2: Implement DataProvider
The `DataProvider` will call by `Chassis` when it need to get data to view from server.  It has a class is `BaseDataProvider` class that generated from the Chassis backend. The usually `Chassis` will send/receive data from `DataProvider` in dynamic type.

Create a new class to extend the `BassDataProvider` *(we create the `AppDataProvider` in the example project)* and implement the method that does not have a definition (implementation), and the `void getData(StreamController<dynamic> controller, ChassisRequest request)` method you must not to do anything.


```dart
/*
  form `data_provider.dart`

  There will be extends `BaseDataProvider` create by your self to allows handle your method for deliver `Stream<Output>` to function `getData`.
*/

/// Generated `BaseDataProvider` from `Chassis` backend
abstract class BaseDataProvider implements DataProvider {
  Stream<BannerOutput> getBanner(BannerInput banner);
  Stream<QuickAccessOutput> getQuickAccessItem();

  @override
  void getData(StreamController<dynamic> controller, ChassisRequest request) {
    switch (request.resolvedWith) {
      case DataProviderConstans.getBanner:
        final input = BannerInput.fromJson(request.input);
        final stream = getBanner(input).map((event) => event.toJson());
        controller.addStream(stream);
        break;
      case DataProviderConstans.getQuickAccessItem:
        final stream = getQuickAccessItem().map((event) => event.toJson());
        controller.addStream(stream);
        break;
      default:
        break;
    }
  }
}

/// The application must extends `BaseDataProvider` by themself
class AppDataProvider extends BaseDataProvider {
  @override
  Stream<BannerOutput> getBanner(BannerInput banner) {
    // TODO: implement getBanner
    throw UnimplementedError();
  }

  @override
  Stream<QuickAccessOutput> getQuickAccessItem() {
    // TODO: implement getQuickAccessItem
    throw UnimplementedError();
  }
}
```

All models in DataProviders, the Chassis backend will generated input/output model from the spec that you define.

In case of `getBanner()` method, we have 2 models is `BannerInput` and `BannerOutput`
```dart
/*
  from `banner_input.dart`
  generated from the `Chassis` backend
*/

class BannerInput {
  final String slug;
  BannerInput.fromJson(Map<String, dynamic> json) : slug = json['slug'];
}

class BannerOutput {
  final String asset;
  final String placeholder;
  
  BannerOutput.fromJson(Map<String, dynamic> json)
      : asset = json['asset'],
        placeholder = json['placeholder'];
        
  Map<String, dynamic> toJson() {
    return {
      'asset': asset,
      'placeholder': placeholder,
    };
  }
}
```

<br />

## Step 3: Implement ViewProvider

The `ViewProvider` will call by `Chassis` when it need to get view by `viewType`. 

It has a class is `BaseViewProvider`, that generate from the Chassis backend. The usually Chassis will send the Stream to `ViewProvider` to receive the data, and `ViewProvider` will provide some view to `Chassis`.

Create a new class to extend the `BaseViewProvider` *(we create the `AppViewProvider` in the example project)* and implement the method that does not have a definition (implementation), and the `Widget  getView(Stream stream,  ChassisItem item)` method you must not to do anything.

```dart
/*
  from `view_provider_base.dart`
*/


/// Generated `BaseViewProvider` from the `Chassis` backend
abstract class BaseViewProvider implements ViewProvider {
  Widget getBannerView(Stream<BannerItem> stream, BannerModel model);
  Widget getQuickAccessView(
      Stream<QuickAccessPayloadData> stream, QuickAccessModel model);

  @override
  Widget getView(Stream stream, ChassisItem item) {
    switch (item.viewType) {
      case ViewType.banner:
        var bannerModel = BannerModel.fromJson(item.toJson());
        var broadcastStream =
            stream.map<BannerItem>((data) => BannerItem.fromJson(data));
        return getBannerView(broadcastStream, bannerModel);

      case ViewType.quickAccess:
        var quickAccessModel = QuickAccessModel.fromJson(item.toJson());
        var broadcastStream = stream.map<QuickAccessPayloadData>(
            (data) => QuickAccessPayloadData.fromJson(data));
        return getQuickAccessView(broadcastStream, quickAccessModel);

      default:
        return Container();
    }
  }
}

/// The application must extends `BaseViewProvider` by themself
class AppViewProvider extends BaseViewProvider {
  @override
  Widget getBannerView(Stream<BannerItem> stream, BannerModel model) {
    // TODO: implement getBannerView
    throw UnimplementedError();
  }

  @override
  Widget getQuickAccessView(Stream<QuickAccessPayloadData> stream, QuickAccessModel model) {
    // TODO: implement getQuickAccessView
    throw UnimplementedError();
  }
}
```

All models in ViewProvider, the `Chassis` backend will generated all models from the spec that you define.

In case of `getBannerView()` method, you can see the example model that `Chassis` backend generated.

	
```dart
/*
  from `banner_model.dart`
  generated from the `Chassis` backend
*/

class BannerModel {
  String id;
  String viewType;
  BannerAttributes attributes;
  BannerModel(
      {required this.id, required this.viewType, required this.attributes});
  BannerModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        viewType = json['viewType'],
        attributes = BannerAttributes.fromJson(json['attributes']);
}

class BannerAttributes {
  String heightPolicy;
  String heightValue;
  String? color;
  BannerAttributes(
      {required this.heightPolicy, required this.heightValue, this.color});
  BannerAttributes.fromJson(Map<String, dynamic> json)
      : heightPolicy = json['heightPolicy'],
        heightValue = json['heightValue'],
        color = json['color'];
}

class BannerPayload {
  String? type;
  BannerItem? data;
  BannerPayload({this.type, this.data});
  BannerPayload.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        data = json['data'] != null ? BannerItem.fromJson(json['data']) : null;
}

class BannerItem {
  String asset;
  String? placeholder;
  BannerItem({required this.asset, this.placeholder});
  BannerItem.fromJson(Map<String, dynamic> json)
      : asset = json['asset'],
        placeholder = json['placeholder'];
}
```
