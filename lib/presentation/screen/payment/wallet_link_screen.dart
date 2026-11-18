import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';
import 'package:nurbox/core/widgets/app_button.dart';

import 'widgets/payment_formatters.dart';
import 'widgets/payment_scaffold.dart';
import 'widgets/payment_text_field.dart';

/// Привязать кошелёк (ввод номера). Route: '/wallet_link'
class WalletLinkScreen extends StatefulWidget {
  const WalletLinkScreen({super.key});

  @override
  State<WalletLinkScreen> createState() => _WalletLinkScreenState();
}

class _WalletLinkScreenState extends State<WalletLinkScreen> {
  final _phone = TextEditingController();

  @override
  void dispose() {
    _phone.dispose();
    super.dispose();
  }

  void _sendCode() {
    final digits = _phone.text.replaceAll(' ', '');
    if (digits.length != 9) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Введите номер полностью')));
      return;
    }
    // TODO: запросить SMS-код через API
    Navigator.of(context)
        .pushNamed('/wallet_confirm', arguments: '+992 ${_phone.text}');
  }

  @override
  Widget build(BuildContext context) {
    return PaymentScaffold(
      title: 'Привязать кошелёк',
      subtitle: 'Укажите номер кошелька\nОтправим код подтверждения по SMS',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PaymentTextField(
            label: 'Номер кошелька',
            controller: _phone,
            hint: '90 123 45 67',
            keyboardType: TextInputType.phone,
            formatters: [GroupedDigitsFormatter.phone],
            prefix: const Padding(
              padding: EdgeInsets.only(left: 16, right: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '+992',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryText,
                    ),
                  ),
                  SizedBox(width: 12),
                  SizedBox(
                    height: 20,
                    child: VerticalDivider(
                      width: 1,
                      thickness: 1,
                      color: AppColors.border,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Номер должен быть привязан к кошельку',
            style: TextStyle(fontSize: 12, color: AppColors.secondaryText),
          ),
        ],
      ),
      bottom: AppButton(text: 'Получить код', onPressed: _sendCode),
    );
  }
}
