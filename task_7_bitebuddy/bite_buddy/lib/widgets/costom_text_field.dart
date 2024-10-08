import 'package:flutter/material.dart';

class CostomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labText;
  final TextInputType? keyboardType;
  const CostomTextField(
      {super.key, this.controller, this.keyboardType, this.labText});
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        labelText: labText,
      ),
    );
  }
}
