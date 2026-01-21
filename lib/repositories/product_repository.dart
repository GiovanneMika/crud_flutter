import 'package:crud_flutter/models/product_model.dart';
import 'package:dio/dio.dart';

class ProductRepository {
  late final Dio dio;
  final url = "http://10.0.2.2:3001/products";

  ProductRepository([Dio? dio]) {
    this.dio = dio ?? Dio();
  }

  Future<List<ProductModel>> getProducts() async {
    final response = await dio.get(url);
    final list = response.data as List;
    return list.map((json) => ProductModel.fromJson(json)).toList();
  }

  Future<ProductModel> createProduct(ProductModel product) async {
    final response = await dio.post(url, data: product.toJson());
    return ProductModel.fromJson(response.data);
  }

  Future<ProductModel> updateProduct(ProductModel product) async {
    final response = await dio.put(
      '$url/${product.id}',
      data: product.toJson(),
    );
    return ProductModel.fromJson(response.data);
  }

  Future<dynamic> deleteProduct(String id) async {
    final response = await dio.delete('$url/${id}');
    return response;
  }
}
