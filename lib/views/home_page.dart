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
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.network(
                  'https://avatars.githubusercontent.com/u/69139838?v=4',
                ),
              ),
              accountName: Text("Giovanne Mika"),
              accountEmail: Text("admin@email.com"),
            ),
            ListTile(
              title: Text("Produtos"),
              subtitle: Text("Tela de Produtos"),
              leading: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Icon(Icons.shopping_cart_outlined, size: 30),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/products');
              },
            ),
            ListTile(
              title: Text("Clientes"),
              subtitle: Text("Tela de Clientes"),
              leading: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Icon(Icons.people_alt, size: 30),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/costumers');
              },
            ),
          ],
        ),
      ),
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
            destino: "/costumers/new",
          ),
        ],
      ),
    );
  }
}
