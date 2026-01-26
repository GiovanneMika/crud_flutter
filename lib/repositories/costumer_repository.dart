// ignore_for_file: avoid_print

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
    return list.map((json) => CostumerModel.fromJson(json)).toList();
  }

  Future<CostumerModel> createCostumer(CostumerModel costumer) async {
    costumer.phone = costumer.phone!.trim().replaceAll(RegExp(r'\D'), '');
    costumer.address!.zipCode = costumer.address!.zipCode!.trim().replaceAll(
      RegExp(r'\D'),
      '',
    );
    final response = await dio.post(url, data: costumer.toJson());
    return CostumerModel.fromJson(response.data);
  }

  Future<CostumerModel> updateCostumer(CostumerModel costumer) async {
    costumer.phone = costumer.phone!.trim().replaceAll(RegExp(r'\D'), '');
    costumer.address!.zipCode = costumer.address!.zipCode!.trim().replaceAll(
      RegExp(r'\D'),
      '',
    );
    final response = await dio.put(
      '$url/${costumer.id}',
      data: costumer.toJson(),
    );
    return CostumerModel.fromJson(response.data);
  }

  Future<dynamic> deleteCostumer(String id) async {
    final response = await dio.delete('$url/$id');
    return response;
  }
}
