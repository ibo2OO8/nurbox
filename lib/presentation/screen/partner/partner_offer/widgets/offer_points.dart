import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';

/// Заголовок «Ваша точка — на карте Nurbox» и список преимуществ.
class OfferPoints extends StatelessWidget {
  const OfferPoints({
    super.key,
    this.title = 'Ваша точка — на карте Nurbox',
    this.points = const [
      'Фото и адрес помогают гостям найти вход',
      'Мы поможем с запуском станции',
    ],
  });

  final String title;
  final List<String> points;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryText,
          ),
        ),
        for (final point in points) ...[
          const SizedBox(height: 16),
          Text(
            point,
            style: const TextStyle(fontSize: 14, color: AppColors.primaryText),
          ),
        ],
      ],
    );
  }
}
