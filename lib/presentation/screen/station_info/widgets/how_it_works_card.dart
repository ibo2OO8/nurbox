import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';

/// Один шаг блока «Как это работает».
class HowStep {
  const HowStep(this.icon, this.text);

  final IconData icon;
  final String text;
}

class HowItWorksCard extends StatelessWidget {
  const HowItWorksCard({
    super.key,
    this.title = 'Как это работает',
    this.steps = defaultSteps,
  });

  static const defaultSteps = [
    HowStep(Icons.qr_code_scanner, 'Сканируйте QR-код на станции'),
    HowStep(Icons.bolt_outlined, 'Заряжайтесь по тарифу'),
    HowStep(Icons.map_outlined, 'Верните пауэрбанк на станции'),
  ];

  final String title;
  final List<HowStep> steps;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: 12),
          for (final step in steps)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Icon(step.icon, size: 18, color: AppColors.primaryText),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      step.text,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.primaryText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
