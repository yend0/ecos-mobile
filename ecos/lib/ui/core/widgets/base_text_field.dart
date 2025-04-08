import 'package:flutter/material.dart';

class BaseTextField extends StatelessWidget {
  const BaseTextField({
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.validator,
    required this.fieldKey,
    super.key,
  });

  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Key fieldKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        key: fieldKey,
        controller: controller,
        textInputAction:
            obscureText ? TextInputAction.done : TextInputAction.next,
        validator: validator,
        obscureText: obscureText,
        keyboardType:
            obscureText ? TextInputType.text : TextInputType.emailAddress,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 12.0),
          hintText: hintText,
          isDense: true,
        ),
      ),
    );
  }
}
