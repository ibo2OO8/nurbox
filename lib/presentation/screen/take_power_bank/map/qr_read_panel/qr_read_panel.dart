import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';
import 'package:nurbox/core/widgets/app_button.dart';
import 'package:nurbox/core/widgets/drag_handle.dart';
import 'package:nurbox/presentation/screen/take_power_bank/map/qr_read_panel/widgets/sheet_handle.dart';

class QrReadPanel extends StatelessWidget {
  const QrReadPanel({
    super.key,
    this.address = defaultAddress,
    this.tariff = defaultTariff,
    this.paymentTiming = defaultPaymentTiming,
    this.cardLabel = defaultCardLabel,
    this.infoText = defaultInfoText,
    this.onPaymentTap,
    this.onConfirm,
  });

  static const defaultAddress = 'Рудаки, 42';
  static const defaultTariff = '60 сом/день';
  static const defaultPaymentTiming = 'После возврата';
  static const defaultCardLabel = 'Visa •••• 4242';
  static const defaultInfoText = 'Возврат в любой станции Nurbox';

  final String address;
  final String tariff;
  final String paymentTiming;
  final String cardLabel;
  final String infoText;
  final VoidCallback? onPaymentTap;
  final VoidCallback? onConfirm;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(child: DragHandle()),
              const SizedBox(height: 20),
              const Text(
                'Взять пауэрбанк',
                style: TextStyle(
                  fontSize: 24,
                  height: 1.2,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryText,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                address,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.secondaryText,
                ),
              ),
              const SizedBox(height: 20),
              const _Divider(),
              const SizedBox(height: 16),
              InfoRow(label: 'Тариф', value: tariff, emphasized: true),
              const SizedBox(height: 14),
              InfoRow(label: 'Оплата', value: paymentTiming),
              const SizedBox(height: 16),
              const _Divider(),
              const SizedBox(height: 19),
              PaymentMethodTile(
                label: cardLabel,
                onTap: () {
                  Navigator.of(context).pushNamed('/payment_method');
                },
              ),
              const SizedBox(height: 16),
              InfoBanner(text: infoText),
              const SizedBox(height: 27),
              AppButton(
                text: 'Взять пауэрбанк',
                onPressed: () {
                  Navigator.of(context).pushNamed('/pickup_power_bank');
                },
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Нажимая, вы принимаете условия аренды',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.secondaryText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, thickness: 1, color: AppColors.border);
  }
}
