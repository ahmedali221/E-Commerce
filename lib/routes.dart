import 'package:ecommerce_app/presentation_layer/screens/cart_screen.dart';
import 'package:ecommerce_app/presentation_layer/screens/home_page.dart';
import 'package:ecommerce_app/presentation_layer/screens/main_page.dart';
import 'package:ecommerce_app/presentation_layer/screens/orders_screen.dart';
import 'package:ecommerce_app/presentation_layer/screens/product_details.dart';
import 'package:flutter/cupertino.dart';

final Map<String, WidgetBuilder> routes = {
  HomePage.routeName: (context) => const HomePage(),
  ProductDetails.routeName: (context) => const ProductDetails(),
  CartScreen.routeName: (context) => const CartScreen(),
  MainPage.routeName: ((context) => const MainPage()),
  OrdersScreen.routeName: (context) => OrdersScreen(),
};
