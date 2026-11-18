import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';
import 'package:nurbox/core/widgets/drag_handle.dart';

import '../station_data.dart';
import 'station_photos.dart';
import 'station_stats.dart';

class StationHeader extends StatelessWidget {
  const StationHeader({
    super.key,
    required this.station,
    this.showPhotos = true,
  });

  final StationData station;

  /// false: фото скрыты (панель свёрнута).
  final bool showPhotos;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
          bottom: Radius.circular(28),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(child: DragHandle()),
          const SizedBox(height: 10),
          Text(
            station.name,
            style: const TextStyle(
              fontSize: 24,
              height: 1.2,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            station.address,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.secondaryText,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              station.hint,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryText,
              ),
            ),
          ),
          const SizedBox(height: 8),
          StationStats(station: station),
          if (showPhotos) ...[
            const SizedBox(height: 10),
            StationPhotos(photos: station.photos),
          ],
        ],
      ),
    );
  }
}
