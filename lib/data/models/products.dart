class Product {
  late String category;
  late String description;
  late String location;
  late String name;
  late String price;
  late int quantity;
  // late String id;
  // late int quantity;
  Product.fromJson(Map<String, dynamic> json) {
    price = json['productPrice'];
    name = json['productName'];
    location = json['productLocation'];
    description = json['productDescription'];
    category = json['productCategory'];
  }
}
