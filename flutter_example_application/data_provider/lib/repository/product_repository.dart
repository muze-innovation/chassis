import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IProductRepository {
  Stream streamProductReccomend();
}

class ProductRepository implements IProductRepository {
  @override
  Stream streamProductReccomend() {
    return FirebaseFirestore.instance
        .collection('quickAccessItem')
        .doc('C31m6JDhRAkqItIzWsKP')
        .snapshots();
  }
}
