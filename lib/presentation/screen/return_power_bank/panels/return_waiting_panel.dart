import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';
import 'package:nurbox/core/widgets/app_button.dart';

import 'widgets/return_panel_surface.dart';
import 'widgets/stat_item.dart';

/// Нижняя панель карты «Ждём подтверждение».
/// Сверху на карте при этом показывается плашка «Проверяем возврат».
class ReturnWaitingPanel extends StatelessWidget {
  const ReturnWaitingPanel({
    super.key,
    this.title = 'Ждём подтверждение',
    this.subtitle = 'Станция проверяет слот',
    this.timeLabel = 'Время',
    this.time = '00:37',
    this.amountLabel = 'Начислено',
    this.amount = '5 сом',
    this.buttonText = 'Проверить статус',
    this.detailsText = 'Детали аренды',
    this.scrollController,
    this.onCheck,
    this.onDetails,
  });

  final String title;
  final String subtitle;
  final String timeLabel;
  final String time;
  final String amountLabel;
  final String amount;
  final String buttonText;
  final String detailsText;
  final ScrollController? scrollController;
  final VoidCallback? onCheck;
  final VoidCallback? onDetails;

  @override
  Widget build(BuildContext context) {
    return ReturnPanelSurface(
      scrollController: scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              height: 1.2,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.secondaryText,
            ),
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, thickness: 1, color: AppColors.border),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: StatItem(label: timeLabel, value: time)),
              Expanded(child: StatItem(label: amountLabel, value: amount)),
            ],
          ),
          const SizedBox(height: 12),
          AppButton(text: buttonText, onPressed: () => onCheck?.call()),
          const SizedBox(height: 4),
          Center(
            child: TextButton(
              onPressed: onDetails,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    detailsText,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.secondaryText,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(
                    Icons.arrow_forward,
                    size: 14,
                    color: AppColors.secondaryText,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
