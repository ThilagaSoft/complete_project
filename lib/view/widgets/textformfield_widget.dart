import 'package:flutter/material.dart';
import 'package:map_pro/core/theme/app_color.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon prefixIcon;

  const TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        filled: true,
        fillColor: AppColors.boxShade,
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none, // no visible border
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '$hintText is required';
        }
        return null;
      },
    );
  }
}
