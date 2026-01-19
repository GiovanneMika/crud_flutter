import 'package:crud_flutter/components/button_box_grid.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}


class _HomePageState extends State<HomePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          ButtonBoxGrid(
            icone: Icons.shopping_cart_outlined,
            titulo: "Ver Produtos",
            cor: Colors.amber,
            destino: "/products",
          ),
          ButtonBoxGrid(
            icone: Icons.person_search,
            titulo: "Ver Clientes",
            cor: Colors.lightBlue,
            destino: "/costumers",
          ),
          ButtonBoxGrid(
            icone: Icons.add_shopping_cart,
            titulo: "Novo Produto",
            cor: Colors.orange,
            destino: "/products/new",
          ),
          ButtonBoxGrid(
            icone: Icons.person_add,
            titulo: "Novo Cliente",
            cor: Colors.blue,
            destino: "/home",
          ),
        ],
      ),
    );
  }
}
