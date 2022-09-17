import 'package:ecommerce_app/business_logic/cubit/cart_cubit.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/data/models/products.dart';
import 'package:ecommerce_app/presentation_layer/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/store/store.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart-screen';
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    List<Product> allProducts = BlocProvider.of<CartCubit>(context).products;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                height: setHeight(context) * 0.839,
                width: setWidth(context),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: setWidth(context) * .13,
                              height: setHeight(context) * 0.06,
                              child: const Icon(Icons.arrow_back_ios),
                              decoration: BoxDecoration(
                                  color: const Color(0xffE5EAEF),
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                          ),
                          SizedBox(
                            width: setWidth(context) * 0.1,
                          ),
                          const SizedBox(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'Shopping Cart',
                                style: TextStyle(
                                    color: Color(0xff1D1C1C),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: setHeight(context) * .03,
                      ),
                      BlocProvider.of<CartCubit>(context).products.isEmpty
                          ? const Center(
                              child: Text(
                                'Your Cart Is Empty',
                                style: TextStyle(
                                    color: Color(0xff1D1C1C),
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: allProducts.length,
                              itemBuilder: (context, index) {
                                return Dismissible(
                                  key: ObjectKey(allProducts[index]),
                                  background: stackBehindDismiss(),
                                  secondaryBackground:
                                      secondarystackBehindDismiss(),
                                  onDismissed: (direction) {
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      setState(() {
                                        BlocProvider.of<CartCubit>(context)
                                            .deletProduct(allProducts[index]);
                                      });
                                    }
                                  },
                                  confirmDismiss:
                                      (DismissDirection direction) async {
                                    return await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Confirm"),
                                          content: direction ==
                                                  DismissDirection.startToEnd
                                              ? const Text(
                                                  "Are you sure you wish add to favorite this item?")
                                              : const Text(
                                                  "Are you sure you wish to delete this item?"),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(true),
                                              child: direction ==
                                                      DismissDirection
                                                          .startToEnd
                                                  ? const Text("FAVORITE")
                                                  : const Text("DELETE"),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(false),
                                              child: const Text("CANCEL"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: CartItem(
                                    allProduct: allProducts[index],
                                  ),
                                );
                              },
                            ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xffE5EAEF)),
                width: setWidth(context),
                height: setHeight(context) * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total: \$ ${getTotalPrice(allProducts)}',
                      style: const TextStyle(
                          color: Color(0xff1D1C1C),
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (BlocProvider.of<CartCubit>(context)
                            .products
                            .isEmpty) {
                          return;
                        } else {
                          showCustomDialog(allProducts, context);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: BlocProvider.of<CartCubit>(context)
                                    .products
                                    .isEmpty
                                ? const Color(0xff1D1C1C).withOpacity(0.4)
                                : const Color(0xff1D1C1C)),
                        width: setWidth(context) * 0.4,
                        height: setHeight(context) * .1,
                        child: const Center(
                          child: Text(
                            'Order Now',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget stackBehindDismiss() {
    return Container(
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: const [
            Icon(Icons.favorite, color: Colors.white),
            Text('Move to favorites', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget secondarystackBehindDismiss() {
    return Container(
      color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Icon(Icons.delete, color: Colors.white),
            Text('Move to trash', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  void showCustomDialog(List<Product> products, context) async {
    var price = getTotalPrice(products);
    String address = '';
    AlertDialog alertDialog = AlertDialog(
      actions: <Widget>[
        MaterialButton(
          onPressed: () {
            try {
              Store _store = Store();
              if (address.isEmpty) {
                return;
              }

              _store.storeOrders(
                  {'TotalPrice': price, 'Address': address}, products);

              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Ordered Successfully'),
              ));
              BlocProvider.of<CartCubit>(context).products.clear();
              Navigator.pop(context);
            } catch (ex) {
              print(ex);
            }
          },
          child: const Text(
            'Confirm',
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 15),
          ),
        )
      ],
      content: TextField(
        onChanged: (value) {
          setState(() {
            address = value;
          });
        },
        decoration: const InputDecoration(hintText: 'Enter your Address'),
      ),
      title: Text('Totall Price  = \$ $price'),
    );
    await showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  getTotalPrice(List<Product> products) {
    int price = 0;
    for (var product in products) {
      price += product.quantity * int.parse(product.price);
    }
    return price;
  }
}
