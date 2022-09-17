import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../business_logic/cubit/products_cubit.dart';
import '../../constants.dart';
import '../../data/models/products.dart';
import '../widgets/category_title.dart';
import '../widgets/product_item.dart';
import 'cart_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  static const routeName = '/main-page';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late List<Product> allProducts;
  late List<Product> newProducts = [];
  bool shirts = false;
  bool jackets = false;
  bool shoes = false;
  bool trousers = false;
  bool fullProduct = true;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductsCubit>(context).getAllProducts();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: ((context, state) {
        if (state is ProductsLoaded) {
          allProducts = (state).products;
          return newProducts.isEmpty
              ? buildProductsList()
              : buildFilteredList();
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }

  Widget buildProductsList() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.8),
        itemCount: allProducts.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return ProductItem(
            allProduct: allProducts[index],
          );
        });
  }

  Widget buildFilteredList() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.8),
        itemCount: newProducts.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return ProductItem(
            allProduct: newProducts[index],
          );
        });
  }

  List<Product> getProductsByCategory(String category) {
    List<Product> filteredProducts = [];
    for (var product in allProducts) {
      if (product.category == category) {
        filteredProducts.add(product);
      }
    }
    return filteredProducts;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    width: setWidth(context) * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: myGrey,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search",
                            icon: Icon(
                              FontAwesomeIcons.search,
                              color: Colors.blue.shade500,
                            )),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: myGrey, width: 2),
                        borderRadius: BorderRadius.circular(50)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        FontAwesomeIcons.shoppingCart,
                        color: Colors.blue.shade500,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      newProducts.clear();
                      setState(() {
                        shirts = false;
                        jackets = false;
                        shoes = false;
                        trousers = false;
                        fullProduct = true;
                      });
                    },
                    child: CategoryTitle(
                      active: fullProduct,
                      text: 'All Products',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      newProducts = getProductsByCategory('shirts');
                      setState(() {
                        shirts = true;
                        jackets = false;
                        shoes = false;
                        trousers = false;
                        fullProduct = false;
                      });
                    },
                    child: CategoryTitle(
                      active: shirts,
                      text: 'Shirts',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      newProducts = getProductsByCategory('jackets');
                      setState(() {
                        shirts = false;
                        jackets = true;
                        shoes = false;
                        trousers = false;
                        fullProduct = false;
                      });
                    },
                    child: CategoryTitle(
                      active: jackets,
                      text: 'Jackets',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      newProducts = getProductsByCategory('shoes');
                      setState(() {
                        shirts = false;
                        jackets = false;
                        shoes = true;
                        trousers = false;
                        fullProduct = false;
                      });
                    },
                    child: CategoryTitle(
                      active: shoes,
                      text: 'Shoes',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      newProducts = getProductsByCategory('trousers');
                      setState(() {
                        shirts = false;
                        jackets = false;
                        shoes = false;
                        trousers = true;
                        fullProduct = false;
                      });
                    },
                    child: CategoryTitle(
                      active: trousers,
                      text: 'Trousers',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            buildBlocWidget(),
          ],
        ),
      ),
    );
  }
}
