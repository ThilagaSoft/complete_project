import 'package:flutter/material.dart';
import 'package:map_pro/core/theme/app_color.dart';
import 'package:map_pro/model/country_model.dart';

class DropdownFieldWidget extends StatelessWidget {
  final Country? value;
  final List<Country> items;
  final String hintText;
  final Function(Country?) onChanged;
  final String? Function(Country?)? validator;

  const DropdownFieldWidget({
    super.key,
    required this.value,
    required this.items,
    required this.hintText,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Country>(
      value: value,
      onChanged: onChanged,
      validator: validator,
      isExpanded: true,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: value == null
              ? const Icon(Icons.flag)
              : null// no prefix icon after selection
        ),
        prefixIconConstraints: value == null
            ? const BoxConstraints(minWidth: 40, minHeight: 40)
            : const BoxConstraints(),
        filled: true,
        fillColor: AppColors.boxShade,
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
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
      items: items.map((country) {
        return DropdownMenuItem<Country>(
          value: country,
          child: Row(
            children: [
              Visibility(child: Image.network(country.flag.png, width: 30, height: 20)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  country.name.common,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
