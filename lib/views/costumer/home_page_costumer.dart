import 'package:crud_flutter/components/button_box_grid.dart';
import 'package:crud_flutter/models/costumer_model.dart';
import 'package:flutter/material.dart';

class HomePageCostumer extends StatefulWidget {
  const HomePageCostumer({super.key});

  @override
  State<HomePageCostumer> createState() {
    return _HomePageCostumerState();
  }
}

class _HomePageCostumerState extends State<HomePageCostumer> {
  @override
  Widget build(BuildContext context) {
    final costumer =
        ModalRoute.of(context)!.settings.arguments as CostumerModel?;

    return Scaffold(
      appBar: AppBar(title: Text('Home Page Costumer')),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.network(
                  costumer?.profileImageUrl ??
                      'https://avatars.githubusercontent.com/u/69139838?v=4',
                  fit: BoxFit.cover,
                ),
              ),
              accountName: Text(costumer?.fullName ?? "Giovanne Mika"),
              accountEmail: Text(costumer?.email ?? "admin@email.com"),
            ),
            ListTile(
              title: Text("Produtos"),
              subtitle: Text("Tela de Produtos"),
              leading: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Icon(Icons.shopping_cart_outlined, size: 30),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/products', arguments: costumer);
              },
            ),
            ListTile(
              title: Text("Perfil"),
              subtitle: Text("Ver Perfil"),
              leading: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Icon(Icons.person, size: 30),
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/costumer/profile',
                  arguments: costumer,
                );
              },
            ),
            ListTile(
              title: Text("Logout"),
              subtitle: Text("Finalizar sessão"),
              leading: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Icon(Icons.logout, size: 30),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/');
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
            arguments: costumer,
          ),
          ButtonBoxGrid(
            icone: Icons.person,
            titulo: "Ver Perfil",
            cor: Colors.lightBlue,
            destino: "/costumer/profile",
            arguments: costumer,
          ),
        ],
      ),
    );
  }
}
