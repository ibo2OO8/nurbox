import 'package:flutter/material.dart';
import 'widgets/payment_scaffold.dart';

/// Карту пока нельзя удалить. Route: '/delete_card_blocked'
class DeleteCardBlockedScreen extends StatelessWidget {
  const DeleteCardBlockedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaymentScaffold(
      leading: const PaymentStatusIcon.warning(),
      title: 'Карту пока нельзя удалить',
      subtitle:
          'Она выбрана для текущей аренды. Добавьте другой способ оплаты и повторите.',
      bottom: PaymentButtons(
        secondaryText: 'Назад',
        onSecondary: () => Navigator.of(context).pop(),
        primaryText: 'Добавить способ',
        onPrimary: () => Navigator.of(context).pushNamed('/add_card'),
      ),
    );
  }
}
