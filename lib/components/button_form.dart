import 'package:flutter/material.dart';

class ButtonForm extends StatelessWidget {
  final String label;
  final Color cor;
  final Color textColor;
  final double padding;
  final double fontSize;
  final Function()? onPressed;

  const ButtonForm({
    super.key,
    required this.label,
    this.cor = Colors.blue,
    this.textColor = Colors.white,
    this.padding = 12.0,
    this.fontSize = 16.0,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(backgroundColor: cor),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Text(
          label,
          style: TextStyle(color: textColor, fontSize: fontSize),
        ),
      ),
    );
  }
}
