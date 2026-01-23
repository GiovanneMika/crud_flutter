import 'package:crud_flutter/models/costumer_model.dart';
import 'package:dio/dio.dart';

class CepRepository {
  late final Dio dio;

  CepRepository([Dio? dio]) {
    this.dio = dio ?? Dio();
  }

  Future<Address?> getAdress(String cep) async {
    try {
      final cepLimpo = cep.replaceAll(RegExp(r'[^0-9]'), '');
      if (cepLimpo.length != 8) {
        throw Exception('CEP inválido');
      }
      final String url = 'https://viacep.com.br/ws/$cepLimpo/json/';
      final response = await dio.get(url);

      if (response.data == null || response.data['erro'] == true) {
        return null;
      }

      return Address(
        street: response.data['logradouro'],
        city: response.data['localidade'],
        state: response.data['uf'],
        zipCode: response.data['cep'],
      );
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }
}
