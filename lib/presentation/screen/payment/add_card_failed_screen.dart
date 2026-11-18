import 'package:flutter/material.dart';
import 'widgets/payment_scaffold.dart';

class AddCardFailedScreen extends StatelessWidget {
  const AddCardFailedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaymentScaffold(
      leading: const PaymentStatusIcon.warning(),
      title: 'Карта не добавлена',
      subtitle: 'Не удалось проверить карту.\nПроверьте данные или попробуйте позже.',
      bottom: PaymentButtons(
        secondaryText: 'Другой способ',
        onSecondary: () => Navigator.of(context)
            .popUntil(ModalRoute.withName('/payment_method')),
        primaryText: 'Ввести ещё раз',
        onPrimary: () => Navigator.of(context).pop(),
      ),
    );
  }
}
