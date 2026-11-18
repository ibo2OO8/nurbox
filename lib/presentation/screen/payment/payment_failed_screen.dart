import 'package:flutter/material.dart';
import 'widgets/payment_scaffold.dart';

/// Оплата не прошла (долг после аренды). Route: '/payment_failed'
/// Аргумент (необязательно): int debt — сумма долга в сомах.
class PaymentFailedScreen extends StatelessWidget {
  const PaymentFailedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final debt = (ModalRoute.of(context)?.settings.arguments as int?) ?? 5;
    return PaymentScaffold(
      leading: const PaymentStatusIcon.warning(),
      title: 'Оплата не прошла',
      subtitle:
          'Аренда завершена, но остался долг $debt сом. Смените способ оплаты и повторите списание.',
      bottom: PaymentButtons(
        secondaryText: 'Изменить способ',
        onSecondary: () => Navigator.of(context).pushNamed('/payment_method'),
        primaryText: 'Повторить оплату',
        onPrimary: () {
          // TODO: повторить списание долга через API
        },
      ),
    );
  }
}
