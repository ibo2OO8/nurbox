import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';
import 'package:nurbox/core/widgets/app_button.dart';

import 'widgets/return_panel_surface.dart';
import 'widgets/step_tile.dart';

class ReturnStationPanel extends StatelessWidget {
  const ReturnStationPanel({
    super.key,
    this.name = 'Рудаки, 42',
    this.info = '120 м · 4 ячейки свободны · 2 занятые',
    this.stepTitle = 'Вставьте пауэрбанк в слот',
    this.stepSubtitle = 'Завершится после сигнала станции',
    this.showAllStations = true,
    this.scrollController,
    this.onCheck,
    this.onAllStations,
  });

  const ReturnStationPanel.unavailable({
    super.key,
    this.name = 'Рудаки, 42',
    this.info = '120 м · 0 свободных ячеек · 6 заняты',
    this.stepTitle = 'Возврат здесь недоступен',
    this.stepSubtitle = 'Выберите другую станцию с местами.',
    this.showAllStations = false,
    this.scrollController,
    VoidCallback? onFindAnother,
    this.onAllStations,
  }) : onCheck = onFindAnother;

  final String name;
  final String info;
  final String stepTitle;
  final String stepSubtitle;
  final bool showAllStations;
  final ScrollController? scrollController;

  final VoidCallback? onCheck;
  final VoidCallback? onAllStations;

  @override
  Widget build(BuildContext context) {
    return ReturnPanelSurface(
      scrollController: scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryText,
                  ),
                ),
              ),
              if (showAllStations)
                InkWell(
                  onTap: onAllStations,
                  borderRadius: BorderRadius.circular(6),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      'Все станции',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryText,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            info,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.secondaryText,
            ),
          ),
          const SizedBox(height: 16),
          StepTile(title: stepTitle, subtitle: stepSubtitle),
          const SizedBox(height: 16),
          AppButton(
            icon: Icons.check_rounded,
            text: 'Проверить статус',
            onPressed: () {
              Navigator.of(context).pushNamed('/return_checking');
            },
          ),
        ],
      ),
    );
  }
}
