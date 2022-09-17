import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/data/models/products.dart';
import 'package:ecommerce_app/data/repository/product_repository.dart';
import 'package:flutter/cupertino.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductRepository productRepository;
  List<Product> products = [];
  ProductsCubit(this.productRepository) : super(ProductsInitial());

  List<Product> getAllProducts() {
    productRepository.getAllProducts().then((products) {
      emit(ProductsLoaded(products));
      this.products = products;
    });
    return products;
  }
}
