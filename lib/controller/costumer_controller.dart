import 'package:crud_flutter/models/costumer_model.dart';
import 'package:crud_flutter/repositories/costumer_repository.dart';
import 'package:flutter/widgets.dart';

class CostumersController {
  List<CostumerModel> costumers = [];
  late final CostumerRepository _repository;
  late final state = ValueNotifier<CostumerState>(CostumerState.initial);

  CostumersController([CostumerRepository? repository]) {
    _repository = repository ?? CostumerRepository();
  }

  Future start() async {
    state.value = CostumerState.loading;
    try {
      costumers = await _repository.getCostumers();
      state.value = CostumerState.success;
    } on Exception catch (e) {
      print(e);
      state.value = CostumerState.error;
    }
  }

  Future<CostumerModel> createCostumer(CostumerModel costumer) async {
    return await _repository.createCostumer(costumer);
  }
}

enum CostumerState { initial, loading, success, error }
