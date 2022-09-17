import 'package:flutter/material.dart';

const myGrey = Color(0xffECEFF3);

double setWidth(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  return width;
}

double setHeight(BuildContext context) {
  final height = MediaQuery.of(context).size.height;
  return height;
}
