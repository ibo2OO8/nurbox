import 'package:flutter/material.dart';
import 'payment_store.dart';
import 'widgets/payment_scaffold.dart';

/// Подтверждение удаления карты. Route: '/delete_card'
class DeleteCardScreen extends StatelessWidget {
  const DeleteCardScreen({super.key});

  void _delete(BuildContext context) {
    final store = PaymentStore.instance;
    // TODO: вызвать API удаления карты
    if (store.cardInUse) {
      Navigator.of(context).pushReplacementNamed('/delete_card_blocked');
      return;
    }
    store.removeCard();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final last4 = PaymentStore.instance.cardLast4 ?? '';
    return PaymentScaffold(
      leading: const PaymentStatusIcon.warning(),
      title: 'Удалить карту?',
      subtitle:
          'Visa •••• $last4 больше не будет доступна. Для аренды потребуется другой способ оплаты.',
      bottom: PaymentButtons(
        secondaryText: 'Удалить карту',
        onSecondary: () => _delete(context),
        primaryText: 'Оставить карту',
        onPrimary: () => Navigator.of(context).pop(),
      ),
    );
  }
}
