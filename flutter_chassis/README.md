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

  

1. Chassis 
2. Data Provider
3. View Provider

  

	View Provider manages and arranges view to show by the response from the server.
In view_provider_base.dart
`.../flutter_example_application/view_provider/lib/src/view_provider_base.dart`
there will be the generated code by the viewType from the server to create the application's view provider abstract class

	```dart
    abstract  class  ViewProvider  implements  IViewProvider {
        Widget  getBannerView(Stream<BannerItem> stream,  BannerModel model);

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

   

	 `Widget getBannerView(Stream<BannerItem> stream, BannerModel model);` will be generated with `BannerItem model` 
 `Widget getView(Stream stream, ChassisItem item)` managed to return the view that the server requested by `viewType` and cast data to the view's model.

	what the user needs to do is just implement `AppViewProvider` class which extends from `ViewProvider`
	

	```dart
    abstrat class AppViewProvider extends ViewProvider {
        @override
        Widget getBannerView(Stream<BannerItem> stream, BannerModel model) {
            //Implement your code here
            return {{BannerView}};
        }
    }
    ```

	implement the user's app banner view in `Widget getBannerView(Stream<BannerItem> stream,  BannerModel model)` which is the method that will be generated automatically.


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