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



## Introduction
A server-driven UI (SDUI) platform implemented by using flutter. Chassis enabled users to rapidly launch mobile applications across iOS and Android.

<img src="/flutter_chassis/assets/chassis_frontend-workflow.jpg"  width="60%">

Chassis provide a shelf-based application which drives by the response from the server. Define the {{blah blah specs}} then chassis will be generated based code for the application including Data Provider and View Provider.

### Benefits
- Ensuring quality of data from the API.
- Easy to read the code between business logic and presentation logic.



## Documentation

- [Getting Started](/flutter_chassis/examples/basic/README.md)
- Use Cases
  - [Action](/flutter_chassis/examples/action/README.md)
  - [Firebase Realtime](/flutter_chassis/examples/.../README.md)



## Prerequisites

| Language | Minimum Version | Installation | Status |
| -------- | --------------- | ------------ | ------ |
| Dart | 2.9.1 | [pub.dev](https://pub.dev) | dev |

**Known Issues**

* Do not support validate spec yet.



## Installation

Run this command:

With Dart:
```
 $ dart pub add flutter_chassis
```

With Flutter:
```
 $ flutter pub add flutter_chassis
```

This will add a line like this to your package's pubspec.yaml (and run an implicit dart pub get):
```
dependencies:
  flutter_chassis: ^0.0.1-dev.1
```
