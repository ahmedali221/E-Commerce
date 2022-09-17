import 'package:ecommerce_app/data/models/products.dart';
import 'package:ecommerce_app/data/web_services/product_web_services.dart';

class ProductRepository {
  final ProductWebServices productWebServices;

  ProductRepository(this.productWebServices);

  Future<List<Product>> getAllProducts() async {
    final products = await productWebServices.getAllProducts();

    // if it doesnot work use the stackoverflow firebase core solution
    print(products.docs
        .map((product) => Product.fromJson(product.data()))
        .toList());
    return products.docs
        .map((product) => Product.fromJson(product.data()))
        .toList();
  }
}
