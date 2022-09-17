import 'package:ecommerce_app/business_logic/cubit/cart_cubit.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/data/models/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = '/product-details';
  const ProductDetails({Key? key}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  double rating = 0;
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final Product allProducts =
        ModalRoute.of(context)!.settings.arguments as Product;

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          width: setWidth(context),
          height: setHeight(context),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  height: setHeight(context) * .03,
                ),
                SizedBox(
                  width: setWidth(context),
                  height: setHeight(context) * 0.4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.asset(
                      allProducts.location,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  height: setHeight(context) * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Text(
                        allProducts.name,
                        style: const TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      child: RatingBar.builder(
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 25,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.black,
                        ),
                        onRatingUpdate: (value) {
                          rating = value;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: setHeight(context) * 0.03,
                ),
                SizedBox(
                  child: Text(
                    allProducts.description,
                    style: const TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${allProducts.price}',
                      style: const TextStyle(
                          fontSize: 35,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: setWidth(context) * 0.20,
                      height: setHeight(context) * 0.05,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                              color: const Color(0xff1D1C1C), width: 2)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              child: const Icon(
                                Icons.remove,
                                size: 15,
                              ),
                              onTap: subtractQuantity,
                            ),
                            Center(
                                child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                '$_quantity',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            )),
                            GestureDetector(
                              onTap: addQuantity,
                              child: const Icon(
                                Icons.add,
                                size: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          addToCart(context, allProducts);
                        });
                      },
                      child: Container(
                        width: setWidth(context) * 0.22,
                        height: MediaQuery.of(context).size.height * 0.08,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: BlocProvider.of<CartCubit>(context)
                                  .products
                                  .contains(allProducts)
                              ? const Color(0xff1D1C1C).withOpacity(0.4)
                              : const Color(0xff1D1C1C),
                        ),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              BlocProvider.of<CartCubit>(context)
                                      .products
                                      .contains(allProducts)
                                  ? 'Added'
                                  : 'Cart',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void subtractQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    } else {
      return;
    }
  }

  void addToCart(BuildContext context, Product product) {
    CartCubit cartItem = BlocProvider.of<CartCubit>(context);
    product.quantity = _quantity;
    bool exist = false;
    List<Product> productsInCart = cartItem.products;
    for (var productInCart in productsInCart) {
      if (productInCart.name == product.name) {
        exist = true;
      }
    }
    if (exist) {
      return;
    } else {
      cartItem.addToCart(product);
      print(productsInCart);
    }
  }
}
