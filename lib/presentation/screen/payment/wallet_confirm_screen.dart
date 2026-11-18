import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';
import 'package:nurbox/core/widgets/app_button.dart';
import 'payment_store.dart';
import 'widgets/payment_scaffold.dart';

/// Подтверждение кошелька SMS-кодом. Route: '/wallet_confirm'
/// Аргумент: String phone, например "+992 90 123 45 67".
class WalletConfirmScreen extends StatefulWidget {
  const WalletConfirmScreen({super.key});

  @override
  State<WalletConfirmScreen> createState() => _WalletConfirmScreenState();
}

class _WalletConfirmScreenState extends State<WalletConfirmScreen> {
  static const _codeLength = 4;
  static const _resendSeconds = 45;

  final _code = TextEditingController();
  final _focus = FocusNode();
  Timer? _timer;
  int _left = _resendSeconds;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _code.addListener(() => setState(() {}));
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _left = _resendSeconds);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_left <= 1) {
        t.cancel();
      }
      setState(() => _left--);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _code.dispose();
    _focus.dispose();
    super.dispose();
  }

  String get _phone =>
      (ModalRoute.of(context)?.settings.arguments as String?) ?? '';

  Future<bool> _verify(String code) async {
    // TODO: проверить код через API
    return code.length == _codeLength;
  }

  Future<void> _confirm() async {
    final ok = await _verify(_code.text);
    if (!mounted) return;
    if (ok) {
      PaymentStore.instance.linkWallet(_phone);
      Navigator.of(context).pushReplacementNamed('/wallet_linked');
    } else {
      Navigator.of(context).pushNamed('/wallet_link_failed');
    }
  }

  void _resend() {
    // TODO: повторно запросить SMS
    _startTimer();
  }

  String get _timerText {
    final m = _left ~/ 60;
    final s = (_left % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final code = _code.text;
    return PaymentScaffold(
      title: 'Подтвердите кошелёк',
      subtitle: 'Отправили SMS на $_phone',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Код из SMS',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryText)),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => _focus.requestFocus(),
            behavior: HitTestBehavior.opaque,
            child: Stack(
              children: [
                Row(
                  children: List.generate(_codeLength, (i) {
                    final filled = i < code.length;
                    final active = i == code.length && _focus.hasFocus;
                    return Expanded(
                      child: Container(
                        height: 56,
                        margin: EdgeInsets.only(
                            right: i == _codeLength - 1 ? 0 : 12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: active
                              ? Border.all(
                                  color: AppColors.primary, width: 1.5)
                              : null,
                        ),
                        child: Text(
                          filled ? code[i] : '',
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryText),
                        ),
                      ),
                    );
                  }),
                ),
                // Скрытое поле ввода поверх ячеек
                Positioned.fill(
                  child: Opacity(
                    opacity: 0,
                    child: TextField(
                      controller: _code,
                      focusNode: _focus,
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(_codeLength),
                      ],
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (_left > 0)
            Text(
              'Отправить код повторно через $_timerText',
              style:
                  const TextStyle(fontSize: 12, color: AppColors.secondaryText),
            )
          else
            GestureDetector(
              onTap: _resend,
              child: const Text('Отправить код ещё раз',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.statusInfo)),
            ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Text('Изменить номер',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryText)),
          ),
        ],
      ),
      bottom: AppButton(text: 'Подтвердить', onPressed: _confirm),
    );
  }
}
