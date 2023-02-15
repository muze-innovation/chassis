import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

mixin IProductRepository {
  Stream streamProductReccomend();
}

class ProductRepository implements IProductRepository {
  @override
  Stream streamProductReccomend() {
    return FirebaseFirestore.instance
        .collection('quickAccessItem') // document ID
        .doc('C31m6JDhRAkqItIzWsKP') // document ID
        .snapshots()
        .map((event) {
      print("ProductRepository: ${event.data()}");
      return event;
    });
  }
}
