import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';
import 'package:nurbox/core/widgets/app_button.dart';
import 'payment_store.dart';
import 'widgets/payment_common.dart';
import 'widgets/payment_scaffold.dart';

/// Кошелёк привязан. Route: '/wallet_linked'
class WalletLinkedScreen extends StatelessWidget {
  const WalletLinkedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final phone = PaymentStore.instance.walletPhone ?? '';
    return PaymentScaffold(
      leading: const PaymentStatusIcon.success(),
      title: 'Кошелёк привязан',
      subtitle: 'Теперь им можно оплачивать аренду.',
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Способ оплаты',
                style:
                    TextStyle(fontSize: 12, color: AppColors.secondaryText)),
            const SizedBox(height: 4),
            const Text('Кошелёк',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryText)),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Divider(height: 1, color: AppColors.border),
            ),
            _Row(label: 'Номер', value: phone),
            const SizedBox(height: 16),
            const _Row(label: 'Статус', value: 'Активен', valueColor: AppColors.success),
          ],
        ),
      ),
      bottom: AppButton(
        text: 'К способам оплаты',
        onPressed: () => Navigator.of(context)
            .popUntil(ModalRoute.withName('/payment_method')),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.value, this.valueColor});

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 13, color: AppColors.secondaryText)),
        Text(value,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: valueColor ?? AppColors.primaryText)),
      ],
    );
  }
}
