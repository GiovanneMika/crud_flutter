import 'package:dio/dio.dart';

class TestConnectionController {
  late final Dio dio;
  final url = "http://10.0.2.2:3001/costumers";

  TestConnectionController() {
    dio = Dio();
  }

  Future<bool> testConnection() async {
    try {
      await dio.get(url).timeout(Duration(seconds: 1));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
