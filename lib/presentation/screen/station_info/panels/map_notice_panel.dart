import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';
import 'package:nurbox/core/widgets/drag_handle.dart';

import '../widgets/station_sheet_surface.dart';

/// Панель с подсказкой на карте, когда станции показать нельзя.
///
///  - `MapNoticePanel.location()`    «Где вы находитесь?»
///  - `MapNoticePanel.offline()`     «Нет соединения» (жёлтая)
///  - `MapNoticePanel.noStations()`  «Рядом нет станций»
///
/// [onAction] решает MapScreen (запрос геолокации, повтор, показать город).
class MapNoticePanel extends StatelessWidget {
  const MapNoticePanel({
    super.key,
    required this.title,
    required this.subtitle,
    required this.actionText,
    required this.caption,
    this.warning = false,
    this.onAction,
  });

  const MapNoticePanel.location({
    super.key,
    this.title = 'Где вы находитесь?',
    this.subtitle = 'Найдём станции рядом с вами',
    this.actionText = 'Разрешить геолокацию',
    this.caption = 'Или перемещайте карту вручную',
    this.onAction,
  }) : warning = false;

  const MapNoticePanel.offline({
    super.key,
    this.title = 'Нет соединения',
    this.subtitle = 'Показаны последние данные карты',
    this.actionText = 'Повторить подключение',
    this.caption = 'Свободные слоты могли измениться',
    this.onAction,
  }) : warning = true;

  const MapNoticePanel.noStations({
    super.key,
    this.title = 'Рядом нет станций',
    this.subtitle = 'Попробуйте увеличить область поиска',
    this.actionText = 'Показать весь город',
    this.caption = 'Или попробуйте позже',
    this.onAction,
  }) : warning = false;

  final String title;
  final String subtitle;
  final String actionText;
  final String caption;
  final bool warning;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return StationSheetSurface(
      children: [
        const Center(child: DragHandle()),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: warning ? AppColors.warningSubtle : AppColors.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryText,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.secondaryText,
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: onAction,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    '$actionText  →',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryText,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          caption,
          style: const TextStyle(fontSize: 12, color: AppColors.secondaryText),
        ),
      ],
    );
  }
}
