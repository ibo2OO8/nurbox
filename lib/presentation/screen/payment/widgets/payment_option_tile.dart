import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';
import 'payment_common.dart';

/// Строка списка способов оплаты.
/// [selected] — серая плашка с галочкой; иначе белая с рамкой (действие).
class PaymentOptionTile extends StatelessWidget {
  const PaymentOptionTile({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.selected = false,
    this.isAction = false,
  });

  final String label;
  final VoidCallback onTap;
  final IconData? icon;
  final bool selected;
  final bool isAction; // «+ Добавить…» / «Удалить карту»

  @override
  Widget build(BuildContext context) {
    final filled = !isAction;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: filled ? AppColors.surface : Colors.white,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: filled ? null : Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 20, color: AppColors.primaryText),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryText),
                  ),
                ),
                if (selected)
                  const Icon(Icons.check_rounded,
                      size: 22, color: AppColors.primaryText),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
