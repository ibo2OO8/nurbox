import 'package:flutter/material.dart';
import 'widgets/payment_scaffold.dart';

/// Не удалось привязать кошелёк. Route: '/wallet_link_failed'
class WalletLinkFailedScreen extends StatelessWidget {
  const WalletLinkFailedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaymentScaffold(
      leading: const PaymentStatusIcon.warning(),
      title: 'Не удалось привязать',
      subtitle:
          'Код неверный или срок действия истёк. Попробуйте ещё раз или выберите карту.',
      bottom: PaymentButtons(
        secondaryText: 'Другой способ',
        onSecondary: () => Navigator.of(context)
            .popUntil(ModalRoute.withName('/payment_method')),
        primaryText: 'Повторить',
        onPrimary: () => Navigator.of(context).pop(),
      ),
    );
  }
}
