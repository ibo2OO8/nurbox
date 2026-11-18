import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';
import 'package:nurbox/core/widgets/app_button.dart';
import 'package:nurbox/presentation/screen/return_power_bank/widgets/notice_card.dart';
import 'package:nurbox/presentation/screen/return_power_bank/widgets/status_screen_layout.dart';

import 'widgets/station_check_card.dart';

/// Экран «Проверяем возврат».
class ReturnCheckingScreen extends StatelessWidget {
  const ReturnCheckingScreen({
    super.key,
    this.title = 'Проверяем возврат',
    this.subtitle = 'Аренда активна до сигнала станции.\nВремя и сумма обновляются на главной.',
    this.stationName = 'Рудаки, 42',
    this.noticeTitle = 'Аренда ещё идёт',
    this.noticeSubtitle = 'До подтверждения возврата',
    this.notConfirmedText = 'Не подтверждается?',
    this.onNotConfirmed,
    this.onCheckStatus,
  });

  final String title;
  final String subtitle;
  final String stationName;
  final String noticeTitle;
  final String noticeSubtitle;
  final String notConfirmedText;

  final VoidCallback? onNotConfirmed;

  /// Кнопка «Проверить статус».
  final VoidCallback? onCheckStatus;

  @override
  Widget build(BuildContext context) {
    return StatusScreenLayout(
      title: title,
      subtitle: subtitle,
      loading: true,
      actions: [
        Center(
          child: TextButton(
            onPressed: onNotConfirmed,
            child: Text(
              notConfirmedText,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.secondaryText,
              ),
            ),
          ),
        ),
        AppButton(
          text: 'Проверить статус',
          onPressed: () {
            Navigator.of(context).pushNamed('/return_success');
          },
        ),
      ],
      child: Column(
        children: [
          StationCheckCard(name: stationName),
          const SizedBox(height: 12),
          NoticeCard(title: noticeTitle, subtitle: noticeSubtitle),
        ],
      ),
    );
  }
}
