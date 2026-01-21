import 'package:crud_flutter/components/button_form.dart';
import 'package:crud_flutter/components/input_form.dart';
import 'package:crud_flutter/controller/products_controller.dart';
import 'package:crud_flutter/models/product_model.dart';
import 'package:flutter/material.dart';

class NewProductPage extends StatefulWidget {
  const NewProductPage({super.key});

  @override
  State<NewProductPage> createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  final controller = ProductsController();
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};

  final _newProduct = ProductModel(
    name: '',
    price: 0.0,
    category: '',
    description: '',
    imageUrl: '',
    stock: 0,
    isAvailable: true,
    tags: [],
    updatedAt: '',
  );

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_newProduct.id == null) {
        controller.createProduct(_newProduct).then((value) {
          Navigator.of(context).pushReplacementNamed('/products');
        });
      } else {
        controller.updateProduct(_newProduct).then((value) {
          Navigator.of(context).pushReplacementNamed('/products');
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ProductModel? product =
        ModalRoute.of(context)!.settings.arguments as ProductModel?;
    if (product != null) {
      _newProduct.id = product.id;
    }
    return Scaffold(
      appBar: AppBar(title: Text('Novo Produto')),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: InputForm(
                      label: "Nome do Produto",
                      padding: 12.0,
                      keyboardType: TextInputType.text,
                      initialValue: product?.name,
                      onSaved: (value) {
                        _newProduct.name = value;
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    child: InputForm(
                      label: "Preço do Produto",
                      padding: 12.0,
                      keyboardType: TextInputType.number,
                      initialValue: product?.price.toString(),
                      onSaved: (value) {
                        _newProduct.price =
                            double.tryParse(value ?? '0') ?? 0.0;
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: InputForm(
                      label: "Categoria do Produto",
                      padding: 12.0,
                      keyboardType: TextInputType.text,
                      initialValue: product?.category,
                      onSaved: (value) {
                        _newProduct.category = value;
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    child: InputForm(
                      label: "Quantidade em Estoque",
                      padding: 12.0,
                      keyboardType: TextInputType.number,
                      initialValue: product?.stock.toString(),
                      onSaved: (value) {
                        _newProduct.stock = int.tryParse(value ?? '0') ?? 0;
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: InputForm(
                      label: "Descrição do Produto",
                      padding: 12.0,
                      keyboardType: TextInputType.text,
                      initialValue: product?.description,
                      onSaved: (value) {
                        _newProduct.description = value;
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: InputForm(
                      label: "Imagem do Produto(URL)",
                      padding: 12.0,
                      keyboardType: TextInputType.url,
                      initialValue: product?.imageUrl,
                      onSaved: (value) {
                        _newProduct.imageUrl = value;
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ButtonForm(
                        label: "Salvar",
                        cor: Colors.blue,
                        onPressed: _saveForm,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ButtonForm(
                        label: "Cancelar",
                        cor: Colors.red,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
