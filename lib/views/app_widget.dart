import 'package:crud_flutter/views/costumers_page.dart';
import 'package:crud_flutter/views/home_page.dart';
import 'package:crud_flutter/views/new_product_page.dart';
import 'package:crud_flutter/views/products_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: false),
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomePage(),
        '/products': (context) => ProductsPage(),
        '/costumers': (context) => CostumersPage(),
        '/products/new': (context) => NewProductPage(),
      },
    );
  }
}
