import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';
import 'package:nurbox/core/widgets/app_button.dart';

class RentalPanel extends StatelessWidget {
  const RentalPanel({
    super.key,
    this.title = 'Пауэрбанк у вас',
    this.subtitle = 'Время идёт до возврата',
    this.timeLabel = 'Время',
    this.time = '00:37',
    this.amountLabel = 'Начислено',
    this.amount = '5 сом',
    this.detailsText = 'Детали аренды',
    this.onDetails,
  });

  final String title;
  final String subtitle;
  final String timeLabel;
  final String time;
  final String amountLabel;
  final String amount;
  final String detailsText;
  final VoidCallback? onDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  height: 1.2,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryText,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.secondaryText,
                ),
              ),
              const SizedBox(height: 16),
              const Divider(height: 1, thickness: 1, color: AppColors.border),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _Stat(label: timeLabel, value: time),
                  ),
                  Expanded(
                    child: _Stat(label: amountLabel, value: amount),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              AppButton(
                icon: Icons.map_outlined,
                text: 'Найти, где вернуть',
                onPressed: () {
                  Navigator.of(context).pushNamed('/map' , arguments: 4);
                },
              ),

              const Spacer(),

              Center(
                child: TextButton(
                  onPressed: onDetails,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        detailsText,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.secondaryText,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(
                        Icons.arrow_forward,
                        size: 16,
                        color: AppColors.secondaryText,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: AppColors.secondaryText),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            height: 1.2,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryText,
          ),
        ),
      ],
    );
  }
}
