import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:flutter/material.dart';

import '../../data/models/orders.dart';
import '../../data/store/store.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders-screen';
  final Store _store = Store();

  OrdersScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrders(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text('there is no orders'),
            );
          } else {
            late List<Order> orders = [];
            for (var doc in snapshot.data!.docs) {
              orders.add(Order(
                documentId: doc.id,
                address: doc['Address'],
                totallPrice: doc['TotalPrice'].toString(),
              ));
            }
            return ListView.builder(
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, OrderDetails.routeName,
                    //     arguments: orders[index].documentId);
                  },
                  child: Container(
                    height: setHeight(context) * .2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.blue,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Totall Price = \$${orders[index].totallPrice}',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Address is ${orders[index].address}',
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              itemCount: orders.length,
            );
          }
        },
      ),
    );
  }
}
