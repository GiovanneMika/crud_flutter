import 'package:crud_flutter/controller/products_controller.dart';
import 'package:crud_flutter/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final controller = ProductsController();

  _success() {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: ListView.builder(
        itemCount: controller.products.length,
        itemBuilder: (context, index) {
          var product = controller.products[index];
          return ListTile(
            title: Text(
              '${product.name} - R\$${product.price!.toStringAsFixed(2).replaceAll('.', ',')}',
            ),
            subtitle: Text('${product.description}'),
            trailing: SizedBox(
              width: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    padding: EdgeInsets.all(0),
                    constraints: BoxConstraints(maxHeight: 30, maxWidth: 30),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed('/products/new', arguments: product)
                          .then((_) => controller.start());
                    },
                    splashRadius: 1,
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    padding: EdgeInsets.all(0),
                    constraints: BoxConstraints(maxHeight: 30, maxWidth: 30),
                    splashRadius: 1,
                    onPressed: () {
                      _modalExclusao(context, product, controller);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
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
      floatingActionButton: AnimatedBuilder(
        animation: controller.state,
        builder: (context, child) {
          if (controller.state.value == ProductState.success) {
            return FloatingActionButton(
              onPressed: () {
                // Navigator.of(
                //   context,
                // ).pushNamed('/products/new').then((_) => controller.start());
                if (controller.state.value == ProductState.success) {
                  Navigator.of(context).pushNamed('/products/new');
                }
              },
              child: Icon(Icons.add),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

Future<void> _modalExclusao(
  BuildContext context,
  ProductModel product,
  ProductsController controller,
) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Excluir ${product.name}"),
        content: Text(
          "Tem certeza que deseja excluir este ${product.name}? Esta ação não pode ser desfeita.",
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
            onPressed: () {
              controller.deleteProduct(product.id!).then((value) {
                controller.start();
              });
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
