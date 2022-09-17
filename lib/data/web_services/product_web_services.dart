import 'package:cloud_firestore/cloud_firestore.dart';

class ProductWebServices {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getProductsStream() {
    final collection = fireStore.collection('Products').snapshots();
    print(collection);
    return collection;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllProducts() async {
    var collection = FirebaseFirestore.instance.collection('Products');
    var querySnapshot = await collection.get();
    return querySnapshot;
  }
}
