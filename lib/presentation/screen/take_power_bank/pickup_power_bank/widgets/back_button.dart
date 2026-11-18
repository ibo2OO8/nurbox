import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';

class BackButton extends StatelessWidget {
  const BackButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onPressed,
        child: const SizedBox(
          width: 44,
          height: 44,
          child: Icon(Icons.arrow_back, size: 22, color: AppColors.primaryText),
        ),
      ),
    );
  }
}
