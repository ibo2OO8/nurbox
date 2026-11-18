import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';
import 'package:nurbox/core/widgets/app_button.dart';
import 'payment_store.dart';
import 'widgets/payment_common.dart';
import 'widgets/payment_formatters.dart';
import 'widgets/payment_scaffold.dart';
import 'widgets/payment_text_field.dart';

/// Добавление карты. Route: '/add_card'
class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _number = TextEditingController();
  final _expiry = TextEditingController();
  final _cvc = TextEditingController();

  @override
  void dispose() {
    _number.dispose();
    _expiry.dispose();
    _cvc.dispose();
    super.dispose();
  }

  bool get _isValid {
    final number = _number.text.replaceAll(' ', '');
    final exp = _expiry.text.split('/');
    if (number.length != 16 || exp.length != 2 || exp[1].length != 2) {
      return false;
    }
    final month = int.tryParse(exp[0]) ?? 0;
    return month >= 1 && month <= 12 && _cvc.text.length == 3;
  }

  Future<void> _save() async {
    // TODO: заменить на реальную проверку/токенизацию карты через API
    final ok = _isValid;
    if (!mounted) return;
    if (ok) {
      final number = _number.text.replaceAll(' ', '');
      PaymentStore.instance.saveCard(number.substring(12));
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pushNamed('/add_card_failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PaymentScaffold(
      title: 'Добавить карту',
      subtitle: 'Для оплаты аренды после возврата',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PaymentTextField(
            label: 'Номер карты',
            controller: _number,
            hint: '0000 0000 0000 0000',
            prefixIcon: Icons.credit_card_rounded,
            formatters: [GroupedDigitsFormatter.card],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: PaymentTextField(
                  label: 'Срок действия',
                  controller: _expiry,
                  hint: 'ММ/ГГ',
                  formatters: [GroupedDigitsFormatter.expiry],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: PaymentTextField(
                  label: 'CVC',
                  controller: _cvc,
                  hint: '•••',
                  obscure: true,
                  formatters: [GroupedDigitsFormatter([3], '')],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Карта сохранится для следующих аренд',
            style: TextStyle(fontSize: 12, color: AppColors.secondaryText),
          ),
        ],
      ),
      bottom: AppButton(text: 'Сохранить карту', onPressed: _save),
    );
  }
}
