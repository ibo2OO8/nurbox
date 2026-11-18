import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';


class ScanButton extends StatelessWidget {
  const ScanButton({super.key, this.text = 'Сканировать'});

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: () => Navigator.of(context).pushNamed('/qr_code'),
        icon: const Icon(Icons.qr_code_scanner, size: 20),
        label: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.primaryOn,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
