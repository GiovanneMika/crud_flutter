import 'package:crud_flutter/controller/products_controller.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final controller = ProductsController();

  _success() {
    return ListView.builder(
      itemCount: controller.products.length,
      itemBuilder: (context, index) {
        var product = controller.products[index];
        return ListTile(title: Text('${product.name}'));
      },
    );
  }

  _error() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          controller.start();
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        child: Text("Tentar novamente"),
      ),
    );
  }

  _loading() {
    return Center(child: CircularProgressIndicator(color: Colors.grey));
  }

  _initial() {
    return Container();
  }

  stateManagement(ProductState state) {
    switch (state) {
      case ProductState.initial:
        return _initial();

      case ProductState.loading:
        return _loading();

      case ProductState.success:
        return _success();

      case ProductState.error:
        return _error();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Produtos')),
      body: AnimatedBuilder(
        animation: controller.state,
        builder: (context, child) {
          return stateManagement(controller.state.value);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/products/new');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
