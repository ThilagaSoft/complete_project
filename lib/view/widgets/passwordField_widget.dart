import 'package:flutter/material.dart';
import 'package:map_pro/core/theme/app_color.dart';

class PasswordFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscurePassword;
  final VoidCallback onChanged;

  const PasswordFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscurePassword,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscurePassword,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(
            obscurePassword ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: onChanged,
        ),
        filled: true,
        fillColor: AppColors.boxShade,
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none, // no visible border
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.purple),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    );
  }
}
