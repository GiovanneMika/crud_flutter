import 'package:crud_flutter/models/product_model.dart';
import 'package:crud_flutter/repositories/product_repository.dart';
import 'package:flutter/widgets.dart';

class ProductsController {
  List<ProductModel> products = [];
  late final ProductRepository _repository;
  late final state = ValueNotifier<ProductState>(ProductState.initial);

  ProductsController([ProductRepository? repository]) {
    _repository = repository ?? ProductRepository();
  }

  Future start() async {
    state.value = ProductState.loading;
    try {
      products = await _repository.getProducts();
      state.value = ProductState.success;
    } on Exception catch (e) {
      print(e);
      state.value = ProductState.error;
    }
  }

  Future<ProductModel> createProduct(ProductModel product) async {
    return await _repository.createProduct(product);
  }
}

enum ProductState { initial, loading, success, error }
