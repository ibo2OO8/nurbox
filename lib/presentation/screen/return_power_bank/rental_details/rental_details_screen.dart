import 'package:flutter/material.dart';
import 'package:nurbox/core/widgets/app_button.dart';
import 'package:nurbox/core/widgets/screen_header.dart';

import 'widgets/details_info_card.dart';
import 'widgets/help_tile.dart';
import 'widgets/rental_status_card.dart';

/// Экран «Детали аренды».
class RentalDetailsScreen extends StatelessWidget {
  const RentalDetailsScreen({
    super.key,
    this.title = 'Детали аренды',
    this.time = '00:37',
    this.amount = '5 сом',
    this.cost = '5 сом / час',
    this.costNote = 'Итог спишется после подтверждения возврата',
    this.payment = 'Visa •••• 4242',
    this.onHelp,
  });

  final String title;
  final String time;
  final String amount;
  final String cost;
  final String costNote;
  final String payment;

  /// Строка «Нужна помощь?».
  final VoidCallback? onHelp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScreenHeader(title: title),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      RentalStatusCard(time: time, amount: amount),
                      const SizedBox(height: 12),
                      DetailsInfoCard(
                        title: 'Стоимость',
                        value: cost,
                        note: costNote,
                      ),
                      const SizedBox(height: 12),
                      DetailsInfoCard(title: 'Способ оплаты', value: payment),
                      const SizedBox(height: 12),
                      HelpTile(onTap: onHelp),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              AppButton(
                text: 'Найти, где вернуть',
                onPressed: () {
                  Navigator.of(context).pushNamed('/return_stations');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
