import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';
import 'package:nurbox/core/widgets/app_back_button.dart';
import 'package:nurbox/core/widgets/app_button.dart';

import 'widgets/offer_photo.dart';
import 'widgets/offer_points.dart';

/// Экран «Гости находят вас на карте»: предложение для заведений.
class PartnerOfferScreen extends StatelessWidget {
  const PartnerOfferScreen({
    super.key,
    this.label = 'ДЛЯ ЗАВЕДЕНИЙ',
    this.title = 'Гости находят\nвас на карте',
    this.subtitle = 'Разместите станцию Nurbox в своей точке.',
    this.image,
    this.buttonText = 'Оставить заявку',
  });

  final String label;
  final String title;
  final String subtitle;

  /// Фото примера. Пусто = серая заглушка.
  final ImageProvider? image;
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppBackButton(),
                      const SizedBox(height: 24),
                      Text(
                        label,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.4,
                          color: AppColors.primaryText,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 28,
                          height: 1.2,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryText,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.secondaryText,
                        ),
                      ),
                      const SizedBox(height: 20),
                      OfferPhoto(image: image),
                      const SizedBox(height: 20),
                      const OfferPoints(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // «Оставить заявку»: открываем форму заявки
              AppButton(
                text: buttonText,
                onPressed: () =>
                    Navigator.of(context).pushNamed('/partner_request'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
