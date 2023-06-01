import 'package:flutter/material.dart';

import '../helper/constants.dart';

class InputField extends StatelessWidget {
  const InputField(
      {super.key,
      required this.labelText,
      required this.prefixIcon,
      this.textEditingController});

  final String labelText;
  final Widget prefixIcon;
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow:  [
          BoxShadow(
            color: Constants.whiteColor, // Shadow color
            spreadRadius: 2, // Spread radius
            blurRadius: 10, // Blur radius
            offset: Offset(0, 0), // Offset in x and y direction
          ),
        ],

      ),
      child: TextField(
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: prefixIcon,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}