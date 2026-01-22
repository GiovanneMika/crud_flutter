import 'package:flutter/material.dart';

class ButtonBoxGrid extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final String destino;
  final Color? cor;

  const ButtonBoxGrid({
    super.key,
    required this.icone,
    required this.titulo,
    this.cor = Colors.cyan,
    required this.destino,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed(destino);
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
