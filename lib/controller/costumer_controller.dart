// ignore_for_file: avoid_print

import 'package:crud_flutter/models/costumer_model.dart';
import 'package:crud_flutter/repositories/cep_repository.dart';
import 'package:crud_flutter/repositories/costumer_repository.dart';
import 'package:flutter/widgets.dart';

class CostumersController {
  List<CostumerModel> costumers = [];
  late final CostumerRepository _repository;
  late final state = ValueNotifier<CostumerState>(CostumerState.initial);
  final _cepRepository = CepRepository();

  CostumersController([CostumerRepository? repository]) {
    _repository = repository ?? CostumerRepository();
  }

  Future start() async {
    state.value = CostumerState.loading;
    try {
      costumers = await _repository.getCostumers().timeout(
        Duration(seconds: 5),
      );
      state.value = CostumerState.success;
    } on Exception catch (e) {
      print(e);
      state.value = CostumerState.error;
    }
  }

  Future<CostumerModel> createCostumer(CostumerModel costumer) async {
    final existingCostumer = await _repository.getCostumerByEmail(
      costumer.email!,
    );
    if (existingCostumer != null) {
      throw Exception('Costumer with this email already exists');
    }
    return await _repository.createCostumer(costumer);
  }

  Future<CostumerModel> updateCostumer(CostumerModel costumer) async {
    return await _repository.updateCostumer(costumer);
  }

  Future<dynamic> deleteCostumer(String id) async {
    return await _repository.deleteCostumer(id);
  }

  Future<CostumerModel?> login(String email, String password) async {
    return await _repository.login(email, password);
  }

  Future<Address?> findAddress(String cep) async {
    try {
      return await _cepRepository.getAdress(cep);
    } catch (e) {
      return null;
    }
  }
}

enum CostumerState { initial, loading, success, error }
