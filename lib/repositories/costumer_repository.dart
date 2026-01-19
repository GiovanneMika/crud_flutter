import 'package:crud_flutter/models/costumer_model.dart';
import 'package:dio/dio.dart';

class CostumerRepository {
  late final Dio dio;
  final url = "http://10.0.2.2:3001/costumers";

  CostumerRepository([Dio? dio]) {
    this.dio = dio ?? Dio();
  }

  Future<List<CostumerModel>> getCostumers() async {
    final response = await dio.get(url);
    final list = response.data as List;
    print(list);
    return list.map((json) => CostumerModel.fromJson(json)).toList();
  }
}
