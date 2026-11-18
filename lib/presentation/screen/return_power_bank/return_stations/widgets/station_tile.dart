import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';

import '../station_item.dart';

/// Карточка станции в списке. Станция без мест серая и не нажимается.
class StationTile extends StatelessWidget {
  const StationTile({
    super.key,
    required this.item,
    this.selected = false,
    this.onTap,
  });

  final StationItem item;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final nameColor =
        item.available ? AppColors.primaryText : AppColors.secondaryText;

    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: selected ? AppColors.primaryText : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: item.available ? onTap : null,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: nameColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.details,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.secondaryText,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  item.status,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: item.available
                        ? FontWeight.w600
                        : FontWeight.w400,
                    color: item.available
                        ? AppColors.primaryText
                        : AppColors.secondaryText,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
