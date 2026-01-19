import 'package:crud_flutter/components/button_box_grid.dart';
import 'package:flutter/material.dart';

class NewProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Novo Produto')),
      body: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Icon(Icons.image, size: 100),
                  TextButton(onPressed: () {}, child: Text('Adicionar Imagem')),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
