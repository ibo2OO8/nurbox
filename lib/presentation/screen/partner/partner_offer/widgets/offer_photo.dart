import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';

/// Фото примера размещения с белой подписью внизу.
/// Если [image] не задано, показывается серая заглушка.
class OfferPhoto extends StatelessWidget {
  const OfferPhoto({
    super.key,
    this.image,
    this.caption = 'Пример размещения',
    this.height = 232,
  });

  final ImageProvider? image;
  final String caption;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (image == null)
              Container(
                color: AppColors.surface,
                child: const Icon(
                  Icons.image_outlined,
                  size: 40,
                  color: AppColors.secondaryText,
                ),
              )
            else
              Image(image: image!, fit: BoxFit.cover),
            Positioned(
              left: 16,
              bottom: 16,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  caption,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryText,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
