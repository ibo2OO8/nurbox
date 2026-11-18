import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';
import 'package:nurbox/core/widgets/drag_handle.dart';

class StationHeaderCard extends StatelessWidget {
  final String title;
  final String address;
  final String locationNote;
  final String workingHours;
  final String statusText;
  final int takeCount;
  final int returnCount;
  final String stationNumber;

  const StationHeaderCard({
    Key? key,
    required this.title,
    required this.address,
    required this.locationNote,
    required this.workingHours,
    required this.statusText,
    required this.takeCount,
    required this.returnCount,
    required this.stationNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      decoration: BoxDecoration(
        color: Colors.white, // Серый фон карточки
        borderRadius: BorderRadius.circular(24), // Скругление всей карточки
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DragHandle(),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.primaryText,
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            address,
            style: const TextStyle(
              color: AppColors.secondaryText,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              locationNote,
              style: const TextStyle(
                color: AppColors.primaryText,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatColumn(workingHours, statusText, isBold: false),
              _buildDivider(),
              _buildStatColumn('Взять', takeCount.toString(), isBold: true),
              _buildDivider(),
              _buildStatColumn('Вернуть', returnCount.toString(), isBold: true),
              _buildDivider(),
              _buildStatColumn('Станция', stationNumber, isBold: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String label, String value, {bool isBold = false}) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.secondaryText,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(height: 28, width: 1, color: AppColors.border);
  }
}
