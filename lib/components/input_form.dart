import 'package:flutter/material.dart';

class InputForm extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final double? padding;
  final String? Function(String?)? onSaved;
  const InputForm({
    super.key,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.padding = 12.0,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding ?? 12.0),
      child: TextFormField(
        keyboardType: keyboardType,
        decoration: InputDecoration(
          label: Text(label),
          border: OutlineInputBorder(),
        ),
        onSaved: onSaved,
      ),
    );
  }
}
