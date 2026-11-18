import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';

import 'phone_formatter.dart';

/// Поле номера: код страны слева, разделитель и ввод цифр.
class PhoneField extends StatelessWidget {
  const PhoneField({
    super.key,
    this.countryCode = '+992',
    this.hint = '90 123 45 67',
    this.hasError = false,
    this.onChanged,
  });

  final String countryCode;
  final String hint;
  final bool hasError;

  /// Отдаёт только цифры без пробелов.
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: hasError ? AppColors.danger : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Text(
            countryCode,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(width: 12),
          Container(width: 1, height: 24, color: AppColors.border),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              autofocus: true,
              keyboardType: TextInputType.phone,
              inputFormatters: [PhoneFormatter()],
              onChanged: (value) =>
                  onChanged?.call(value.replaceAll(' ', '')),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryText,
              ),
              decoration: InputDecoration.collapsed(
                hintText: hint,
                hintStyle: const TextStyle(
                  fontSize: 16,
                  color: AppColors.secondaryText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}