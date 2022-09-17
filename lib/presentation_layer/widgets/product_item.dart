import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/data/models/products.dart';
import 'package:ecommerce_app/presentation_layer/screens/product_details.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final Product allProduct;

  const ProductItem({Key? key, required this.allProduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(ProductDetails.routeName, arguments: allProduct);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xff1D1C1C),
            // gradient: const LinearGradient(
            //   colors: [
            //     Color(0xffFF2CDF),
            //     Color(0xff00E5FF),
            //   ],
            // ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: setHeight(context) * 0.17,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  child: Image(
                    fit: BoxFit.fill,
                    image: AssetImage(allProduct.location),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  allProduct.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              Text(
                '\$ ${allProduct.price}',
                style: const TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
