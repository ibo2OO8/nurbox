import 'package:flutter/material.dart';
import 'package:nurbox/core/widgets/app_button.dart';

import 'payment_store.dart';
import 'widgets/payment_option_tile.dart';
import 'widgets/payment_scaffold.dart';

/// Выбор способа: карта или кошелёк. Route: '/payment_method'
class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = PaymentStore.instance;
    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        final hasCard = store.cardLast4 != null;
        final hasWallet = store.walletPhone != null;

        return PaymentScaffold(
          title: 'Способ оплаты',
          subtitle: 'Карта или кошелёк · только безналично',
          body: Column(
            children: [
              if (hasCard)
                PaymentOptionTile(
                  icon: Icons.credit_card_rounded,
                  label: 'Visa •••• ${store.cardLast4}',
                  selected: store.selected == PaymentMethodType.card,
                  onTap: () => store.select(PaymentMethodType.card),
                ),
              if (hasWallet)
                PaymentOptionTile(
                  label: 'Кошелёк · ${store.walletPhone}',
                  selected: store.selected == PaymentMethodType.wallet,
                  onTap: () => store.select(PaymentMethodType.wallet),
                ),
              PaymentOptionTile(
                isAction: true,
                label: '+  Добавить карту',
                onTap: () => Navigator.of(context).pushNamed('/add_card'),
              ),
              if (!hasWallet)
                PaymentOptionTile(
                  isAction: true,
                  label: '+  Привязать кошелёк',
                  onTap: () => Navigator.of(context).pushNamed('/wallet_link'),
                ),
              if (hasCard)
                PaymentOptionTile(
                  isAction: true,
                  label: 'Удалить карту',
                  onTap: () => Navigator.of(context).pushNamed('/delete_card'),
                ),
            ],
          ),
          bottom: AppButton(
            text: 'Готово',
            onPressed: () => Navigator.of(context).pop(),
          ),
        );
      },
    );
  }
}
