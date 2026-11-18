import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';

class SquareIconButton extends StatelessWidget {
  const SquareIconButton({super.key, required this.icon, this.onPressed});

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onPressed,
        child: SizedBox(
          width: 44,
          height: 44,
          child: Icon(icon, size: 22, color: AppColors.primaryText),
        ),
      ),
    );
  }
}
