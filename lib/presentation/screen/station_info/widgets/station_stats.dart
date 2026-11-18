import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';

import '../station_data.dart';

// Строка из 4 показателей: часы, взять, вернуть, номер станции.
class StationStats extends StatelessWidget {
  const StationStats({
    super.key,
    required this.station,
    this.takeLabel = 'Взять',
    this.returnLabel = 'Вернуть',
    this.stationLabel = 'Станция',
  });

  final StationData station;
  final String takeLabel;
  final String returnLabel;
  final String stationLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Stat(label: station.workUntil, value: station.status),
          const StatDivider(),
          Stat(label: takeLabel, value: station.takeCount),
          const StatDivider(),
          Stat(label: returnLabel, value: station.returnCount),
          const StatDivider(),
          Stat(label: stationLabel, value: station.number),
        ],
      ),
    );
  }
}

class StatDivider extends StatelessWidget {
  const StatDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 52, color: const Color(0xFFE0E3E8));
  }
}

class Stat extends StatelessWidget {
  const Stat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.secondaryText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryText,
            ),
          ),
        ],
      ),
    );
  }
}
