import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';

/// Фото станции. 2 и больше фото: широкое слева и узкое справа.
/// Одно фото: на всю ширину. Нет фото: серая заглушка.
class StationPhotos extends StatelessWidget {
  const StationPhotos({super.key, required this.photos, this.height = 130});

  final List<ImageProvider> photos;
  final double height;

  @override
  Widget build(BuildContext context) {
    if (photos.length >= 2) {
      return SizedBox(
        height: height,
        child: Row(
          children: [
            Expanded(flex: 3, child: _Photo(photos[0])),
            const SizedBox(width: 8),
            Expanded(flex: 2, child: _Photo(photos[1])),
          ],
        ),
      );
    }
    return SizedBox(
      height: height,
      width: double.infinity,
      child: _Photo(photos.isEmpty ? null : photos.first),
    );
  }
}

class _Photo extends StatelessWidget {
  const _Photo(this.image);

  final ImageProvider? image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: image == null
          ? Container(
              color: AppColors.surface,
              child: const Center(
                child: Icon(
                  Icons.eighteen_mp,
                  size: 32,
                  color: AppColors.success,
                ),
              ),
            )
          : Image(image: image!, fit: BoxFit.cover),
    );
  }
}
