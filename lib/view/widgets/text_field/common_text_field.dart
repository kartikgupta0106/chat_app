
import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final TextInputType? keyboardType;
  final String hintText;
  final TextEditingController? controller;

  const CommonTextField({Key? key, this.keyboardType, required this.hintText, this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black26),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(
            bottom: 7,
            left: 15,
            top:  8,
            right: 15,
          ),),
    );
  }
}