import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/data/repository/product_repository.dart';
import 'package:ecommerce_app/data/web_services/product_web_services.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CategoryTitle extends StatelessWidget {
  bool active;
  final String text;
  // final Shader linearGradient = const LinearGradient(
  //   colors: <Color>[Color(0xffFF2CDF), Color(0xff00E5FF)],
  // ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  // final Shader newColor = const LinearGradient(
  //   colors: <Color>[Color.fromARGB(255, 0, 0, 0), Color.fromARGB(255, 8, 8, 8)],
  // ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  final ProductWebServices productWebServices = ProductWebServices();
  final ProductRepository productRepository =
      ProductRepository(ProductWebServices());

  CategoryTitle({
    Key? key,
    required this.active,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Text(
          text,
          style: TextStyle(
              // foreground: Paint()..shader = linearGradient,
              fontWeight: FontWeight.bold,
              color: active
                  ? Colors.blue.shade600
                  : Colors.black.withOpacity(0.4)),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: active ? Colors.blue.shade600 : myGrey, width: 2),
        ),
      ),
    );
  }
}
