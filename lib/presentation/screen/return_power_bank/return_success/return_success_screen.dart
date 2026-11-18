import 'package:flutter/material.dart';
import 'package:nurbox/core/widgets/app_button.dart';
import 'package:nurbox/presentation/screen/return_power_bank/widgets/status_screen_layout.dart';

import 'widgets/receipt_card.dart';

/// Экран «Пауэрбанк возвращён».
class ReturnSuccessScreen extends StatelessWidget {
  const ReturnSuccessScreen({
    super.key,
    this.title = 'Пауэрбанк возвращён',
    this.subtitle = 'Аренда завершена. Спасибо!',
    this.total = '5 сом',
    this.time = '37 минут',
    this.card = '•••• 4242',
    this.buttonText = 'На карту',
  });

  final String title;
  final String subtitle;
  final String total;
  final String time;
  final String card;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return StatusScreenLayout(
      title: title,
      subtitle: subtitle,
      icon: Icons.check,
      showBack: false,
      actions: [
        AppButton(
          text: buttonText,
          onPressed: () {
            Navigator.of(context).pushNamed('/map', arguments: 0);
          },
        ),
      ],
      child: ReceiptCard(total: total, time: time, card: card),
    );
  }
}
