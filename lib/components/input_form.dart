import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputForm extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final double? padding;
  final String? Function(String?)? onSaved;
  final String? initialValue;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final void Function(String?)? onChanged;

  const InputForm({
    super.key,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.padding = 12.0,
    this.onSaved,
    this.initialValue,
    this.validator,
    this.inputFormatters,
    this.controller,
    this.onChanged,
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
        initialValue: controller == null ? initialValue : null,
        validator: validator,
        inputFormatters: inputFormatters,
        controller: controller,
        onChanged: onChanged,
      ),
    );
  }
}
