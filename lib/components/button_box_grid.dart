import 'package:crud_flutter/controller/test_connection_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ButtonBoxGrid extends StatelessWidget {
  final testController = TestConnectionController();
  final IconData icone;
  final String titulo;
  final String destino;
  final Color? cor;
  final bool? hasTestConnection;

  ButtonBoxGrid({
    super.key,
    required this.icone,
    required this.titulo,
    this.cor = Colors.cyan,
    required this.destino,
    this.hasTestConnection = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () async {
          if (!hasTestConnection!) {
            Navigator.of(context).pushNamed(destino);
          } else {
            if (await testController.testConnection()) {
              Navigator.of(context).pushNamed(destino);
            } else {
              Fluttertoast.showToast(
                msg: "Conexão com o servidor perdida, tente novamente!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: const Color.fromARGB(255, 211, 26, 26),
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }
          }
        },
        style: ElevatedButton.styleFrom(backgroundColor: cor),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icone, fill: 1, color: Colors.white, weight: 700, size: 50),
              Text(
                titulo,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
