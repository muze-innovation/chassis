A `Firebase` project is an example project to show you how to use the Chassis library with Firebase Cloud Firestore.

## Getting Started
### Step 1: Setup Firebase 
Follow this [link](https://firebase.google.com/docs/web/setup) for setup firebase to use the Firebase for run project `fribase` example
### Step 2: Setup Cloud Firestore
Create Cloud Firestore follow this image.
![Pipeline](https://firebasestorage.googleapis.com/v0/b/chassis-376410.appspot.com/o/chassis_firebase_example.png?alt=media&token=33a83a59-ddd4-46d7-b848-e41a8ed41fe0)
Next, Change collection ID and document ID `product_repository.dart` at  `../examples/firebase/lib/data/repositories/product_repository.dart`
```dart
class ProductRepository implements IProductRepository {
  @override
  Stream streamProductReccomend() {
    return FirebaseFirestore.instance
        .collection('quickAccessItem') // collection ID
        .doc('C31m6JDhRAkqItIzWsKP') // document ID
        .snapshots()
        .map((event) {
      print("ProductRepository: ${event.data()}");
      return event;
    });
  }
}
```
Example response
```json
{
   "item":[
      {
         "asset":"link image",
         "title":"title"
      }
   ]
}
```
### Step 3: Install FlutterFire CLI
The FlutterFire CLI depends on the underlying Firebase CLI. If you haven't already done so, make sure you have the Firebase CLI installed on your machine. If not, make sure you have node.js on your machine and Install the Firebase CLI via npm by running the following command:
```
 $ npm install -g firebase-tools
```
Next, install the FlutterFire CLI by running the following command:
```
dart pub global activate flutterfire_cli
```
### Step 4: Generates a `firebase_options.dart`
Change the current working directory by running the following command:
```
$ cd firebase
```
Next, Generates a firebase_options.dart file which can be provided to the options parameter by running the following command:
```
$ flutterfire configure
```
Learn more about the FlutterFire CLI in the [documentation](https://firebase.flutter.dev/docs/overview).
