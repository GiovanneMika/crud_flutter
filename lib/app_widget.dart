import 'package:crud_flutter/views/costumer/costumer_profile.dart';
import 'package:crud_flutter/views/admin/costumers_page.dart';
import 'package:crud_flutter/views/admin/home_page.dart';
import 'package:crud_flutter/views/costumer/home_page_costumer.dart';
import 'package:crud_flutter/views/login_page.dart';
import 'package:crud_flutter/views/admin/new_costumer_page.dart';
import 'package:crud_flutter/views/admin/new_product_page.dart';
import 'package:crud_flutter/views/admin/products_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: false),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/costumer-home': (context) => HomePageCostumer(),
        '/products': (context) => ProductsPage(),
        '/costumers': (context) => CostumersPage(),
        '/products/new': (context) => NewProductPage(),
        '/costumers/new': (context) => NewClient(),
        '/costumer/profile': (context) => CostumerProfile(),
      },
    );
  }
}
