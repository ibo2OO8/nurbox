import 'package:flutter/material.dart';
import 'package:nurbox/core/widgets/app_button.dart';
import 'package:nurbox/presentation/screen/return_power_bank/widgets/notice_card.dart';
import 'package:nurbox/presentation/screen/return_power_bank/widgets/secondary_button.dart';
import 'package:nurbox/presentation/screen/return_power_bank/widgets/status_screen_layout.dart';

/// Экран «Возврат не подтверждён».
class ReturnFailedScreen extends StatelessWidget {
  const ReturnFailedScreen({
    super.key,
    this.title = 'Возврат не подтверждён',
    this.subtitle = 'Станция пока не распознала пауэрбанк.',
    this.noticeTitle = 'Проверьте слот',
    this.noticeSubtitle =
        'Вставьте устройство до щелчка.\nПока аренда продолжается.',
    this.backToStationText = 'Вернуться к станции',
    this.retryText = 'Проверить снова',
    this.onBackToStation,
    this.onRetry,
  });

  final String title;
  final String subtitle;
  final String noticeTitle;
  final String noticeSubtitle;
  final String backToStationText;
  final String retryText;

  /// Серая кнопка «Вернуться к станции».
  final VoidCallback? onBackToStation;

  /// Жёлтая кнопка «Проверить снова».
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return StatusScreenLayout(
      title: title,
      subtitle: subtitle,
      icon: Icons.warning_amber_rounded,
      child: NoticeCard(title: noticeTitle, subtitle: noticeSubtitle),
      actions: [
        SecondaryButton(text: backToStationText, onPressed: onBackToStation),
        AppButton(text: retryText, onPressed: () => onRetry?.call()),
      ],
    );
  }
}
