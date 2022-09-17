import 'package:ecommerce_app/business_logic/cubit/cart_cubit.dart';
import 'package:ecommerce_app/business_logic/cubit/products_cubit.dart';
import 'package:ecommerce_app/data/repository/product_repository.dart';
import 'package:ecommerce_app/data/web_services/product_web_services.dart';
import 'package:ecommerce_app/presentation_layer/screens/home_page.dart';
import 'package:ecommerce_app/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key) {
    productRepository = ProductRepository(ProductWebServices());
    productsCubit = ProductsCubit(productRepository);
    cartCubit = CartCubit();
  }

  late ProductRepository productRepository;
  late ProductsCubit productsCubit;
  late CartCubit cartCubit;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => productsCubit,
        ),
        BlocProvider(create: (context) => cartCubit),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: routes,
        home: const HomePage(),
      ),
    );
  }
}
