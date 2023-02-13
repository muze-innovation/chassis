<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->
# Chassis

  

A server-driven UI (SDUI) platform implemented by using flutter. Chassis enabled users to rapidly launch mobile applications across iOS and Android.

Chassis provide a shelf-based application which drives by the response from the server. Define the {{blah blah specs}} then chassis will be generated based code for the application including Data Provider and View Provider.

  

## Getting Started

  

### How it works

  

There are 3 main parts of Chassis including Chassis Core, Data Provider and View Provider.

  

#### 1. Chassis 
#### 2. Data Provider
   

    Data provide allows you stream response and validate output form your server.
###### In data_provider.dart
`../data/data_provider.dart` There are 2 classes consisting of `BassDataProvider class` and `AppDataProvider class`.

###### BassDataProvider Class
There will be generated code by playload type `remote` from the server to create the application's data provider abstract class. Function `getData` will be add stream output by `request.resolvedWith`.
```dart
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
```
###### AppDataProvider Class
There will be extends `BaseDataProvider` create by your self to allows handle your method for deliver `Stream<Output>` to function `getData`.
```dart
class AppDataProvider extends BaseDataProvider {
  final _bannerRepository = BannerRepository();
  final _productRepository = ProductRepository();

  @override
  Stream<BannerOutput> getBanner(BannerInput banner) {
    return _bannerRepository
        .getData(banner.slug)
        .asStream()
        .map((event) => BannerOutput.fromJson(event));
  }

  @override
  Stream<QuickAccessOutput> getQuickAccessItem() {
    return _productRepository
        .getData()
        .asStream()
        .map((event) => QuickAccessOutput.fromJson(event));
  }
```
###### Input Model
There will be generated model class by playload type `remote` and `request.resolvedWith` from the server if your method is requeied for example `../models/banner_input.dart`.
```dart
class BannerInput {
  final String slug;
  BannerInput.fromJson(Map<String, dynamic> json) : slug = json['slug'];
}
```
###### Output Model
There will be generated model class by playload type `remote` and `request.resolvedWith` from the server to validate output form your method for example `../models/banner_output.dart`.
```dart
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

#### 3. View Provider

  

	View Provider manages and arranges view to show by the response from the server.
In view_provider_base.dart
`.../flutter_example_application/view_provider/lib/src/view_provider_base.dart`
there will be the generated code by the viewType from the server to create the application's view provider abstract class

```dart
    abstract  class  ViewProvider  implements  IViewProvider {
        final  IAction delegate;
        ViewProvider({required  this.delegate});
        Widget  getBannerView(Stream<BannerItem> stream,  BannerModel model,  IAction delegate);

        @override
        Widget  getView(Stream stream,  ChassisItem item) {
            switch (item.viewType) {
            case  ViewTypeConstant.Banner:
                var bannerModel =  BannerModel.fromJson(item.toJson());
                var broadcastStream = stream.map<BannerItem>((data) =>  BannerItem.fromJson(data));
                return  getBannerView(broadcastStream, bannerModel, delegate);
            default:
            return  Container();
            }
        }
    }
```

   

	 `Widget getBannerView(Stream<BannerItem> stream, BannerModel model, IAction delegate);` will be generated with `BannerItem model` 
 `Widget getView(Stream stream, ChassisItem item)` managed to return the view that the server requested by `viewType` and cast data to the view's model.

	what the user needs to do is just implement `AppViewProvider` class which extends from `ViewProvider`
	

	```dart
    abstrat class AppViewProvider extends ViewProvider {
        final IAction delegate;
        AppViewProvider({required this.delegate}): super(delegate: delegate);
        
        @override
        Widget getBannerView(Stream<BannerItem> stream, BannerModel model, IAction delegate) {
            //Implement your code here
            return {{BannerView}};
        }
    }
    ```

	implement the user's app banner view in `Widget getBannerView(Stream<BannerItem> stream,  BannerModel model,  IAction delegate)` which is the method that will be generated automatically.


### Prerequisites

  

The things you need before installing the software.

  

* You need this

* And you need this

* Oh, and don't forget this

  

### Installation

  

A step by step guide that will tell you how to get the development environment up and running.

  

```

$ First step

$ Another step

$ Final step

```

  

## Usage

  

A few examples of useful commands and/or tasks.

  

```

$ First example

$ Second example

$ And keep this in mind

```

  

## Deployment

  

Additional notes on how to deploy this on a live or release system. Explaining the most important branches, what pipelines they trigger and how to update the database (if anything special).

  

### Server

  

* Live:

* Release:

* Development:

  

### Branches

  

* Master:

* Feature:

* Bugfix:

* etc...

  

## Additional Documentation and Acknowledgments

  

* Project folder on server:

* Confluence link:

* Asana board:

* etc...
