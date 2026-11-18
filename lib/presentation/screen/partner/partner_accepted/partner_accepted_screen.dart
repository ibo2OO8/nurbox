import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';
import 'package:nurbox/core/widgets/app_button.dart';

/// Экран «Заявка принята».
class PartnerAcceptedScreen extends StatelessWidget {
  const PartnerAcceptedScreen({
    super.key,
    this.title = 'Заявка принята',
    this.subtitle = 'Спасибо! Мы свяжемся с вами\nпо указанному номеру.',
    this.buttonText = 'На карту',
  });

  final String title;
  final String subtitle;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.check,
                          size: 32,
                          color: AppColors.primaryOn,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryText,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        subtitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 13,
                          height: 1.4,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // «На карту»: открываем карту с главной панелью
              AppButton(
                text: buttonText,
                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  '/map',
                  (route) => false,
                  arguments: 0, // 0 = панель main
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
