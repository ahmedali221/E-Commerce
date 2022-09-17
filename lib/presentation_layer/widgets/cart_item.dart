import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/data/models/products.dart';
import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  Product allProduct;

  CartItem({Key? key, required this.allProduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: setWidth(context),
      height: setHeight(context) * 0.15,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          SizedBox(
            width: setWidth(context) * 0.4,
            height: setHeight(context),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(allProduct.location, fit: BoxFit.fill)),
          ),
          SizedBox(
            width: setWidth(context) * 0.03,
          ),
          SizedBox(
            width: setWidth(context) * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  allProduct.name,
                  style: const TextStyle(
                      color: Color(0xff1D1C1C),
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${allProduct.price}',
                      style:
                          TextStyle(color: Colors.grey.shade700, fontSize: 15),
                    ),
                    Text(
                      'x${allProduct.quantity.toString()}',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
