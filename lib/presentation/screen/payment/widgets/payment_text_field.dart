import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';

class PaymentTextField extends StatelessWidget {
  const PaymentTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.hint,
    this.formatters,
    this.keyboardType = TextInputType.number,
    this.prefix,
    this.prefixIcon,
    this.obscure = false,
    this.onChanged,
  });

  final String label;
  final TextEditingController controller;
  final String hint;
  final List<TextInputFormatter>? formatters;
  final TextInputType keyboardType;
  final Widget? prefix;
  final IconData? prefixIcon;
  final bool obscure;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryText,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: formatters,
          obscureText: obscure,
          onChanged: onChanged,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryText,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: AppColors.secondaryText),
            filled: true,
            fillColor: AppColors.surface,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            prefixIcon:
                prefix ??
                (prefixIcon != null
                    ? Icon(prefixIcon, size: 20, color: AppColors.secondaryText)
                    : null),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
