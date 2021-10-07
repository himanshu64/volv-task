import 'package:flutter/material.dart';

class UserTextField extends StatelessWidget {
  final String titleLabel;
  final Widget? prefixChild;
  final int maxLength;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType inputType;
  const UserTextField(
      {Key? key,
      required this.titleLabel,
      required this.maxLength,
      this.prefixChild,
      required this.icon,
      required this.controller,
      required this.inputType})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        maxLength: maxLength,
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: titleLabel,
          suffixIcon: Icon(
            icon,
            color: Colors.black,
          ),
          prefixIcon: prefixChild,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
