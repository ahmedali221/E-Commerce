import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/data/models/products.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  List<Product> products = [];

  addToCart(Product product) {
    products.add(product);
  }

  deletProduct(Product product) {
    products.remove(product);
  }
}
