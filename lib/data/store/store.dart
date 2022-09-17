import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/products.dart';

class Store {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> loadOrders() {
    return _fireStore.collection('Orders').snapshots();
  }

  Stream<QuerySnapshot> loadOrderDetails(documentId) {
    return _fireStore
        .collection('Orders')
        .doc(documentId)
        .collection('OrderDetails')
        .snapshots();
  }

  storeOrders(data, List<Product> products) {
    var documentRef = _fireStore.collection('Orders').doc();
    documentRef.set(data);
    for (var product in products) {
      documentRef.collection('OrderDetails').doc().set({
        'productName': product.name,
        'productPrice': product.price,
        'Quantity': product.quantity,
        'productLocation': product.location,
        'productCategory': product.category
      });
    }
  }
}
