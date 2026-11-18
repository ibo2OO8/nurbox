import 'package:flutter/material.dart';
import 'package:nurbox/core/widgets/app_button.dart';
import 'package:nurbox/core/widgets/screen_header.dart';
import 'package:nurbox/presentation/screen/profile/sms_code/widgets/sms_code_form.dart';
import 'package:nurbox/presentation/screen/profile/sms_code/widgets/sms_code_status.dart';
import 'package:nurbox/presentation/screen/profile/sms_code/widgets/too_many_attempts_view.dart';

class SmsCodeScreen extends StatefulWidget {
  const SmsCodeScreen({
    super.key,
    this.phone = '+992 90 123 45 67',
    this.codeLength = 4,
    this.status = SmsCodeStatus.initial,
    this.resendIn = '0:45',
    this.onResend,
    this.onChangePhone,
  });

  final String phone;
  final int codeLength;

  /// Какое состояние показать. Меняй при ответе сервера.
  final SmsCodeStatus status;

  /// Текст оставшегося времени до повторной отправки.
  final String resendIn;

  /// Получает введённый код.
  final VoidCallback? onResend;
  final VoidCallback? onChangePhone;

  @override
  State<SmsCodeScreen> createState() => _SmsCodeScreenState();
}

class _SmsCodeScreenState extends State<SmsCodeScreen> {
  late SmsCodeStatus _status = widget.status;
  String _code = '';

  @override
  void didUpdateWidget(covariant SmsCodeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.status != widget.status) _status = widget.status;
  }

  void _onCodeChanged(String value) {
    setState(() {
      _code = value;
      // Как только пользователь начал вводить заново, ошибка пропадает.
      if (_status == SmsCodeStatus.invalidCode) _status = SmsCodeStatus.initial;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tooMany = _status == SmsCodeStatus.tooManyAttempts;
    final expired = _status == SmsCodeStatus.expired;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScreenHeader(
                title: tooMany ? 'Слишком много попыток' : 'Введите код',
                subtitle: tooMany
                    ? 'Новый код можно запросить через 15 минут'
                    : 'Отправили SMS на ${widget.phone}',
              ),
              const SizedBox(height: 32),
              if (tooMany)
                TooManyAttemptsView(onChangePhone: widget.onChangePhone)
              else
                SmsCodeForm(
                  status: _status,
                  codeLength: widget.codeLength,
                  resendIn: widget.resendIn,
                  onChanged: _onCodeChanged,
                  onChangePhone: widget.onChangePhone,
                ),
              const Spacer(),
              if (tooMany)
                AppButton(
                  text: 'Вернуться к номеру',
                  onPressed: () => widget.onChangePhone?.call(),
                )
              else if (expired)
                AppButton(
                  text: 'Отправить новый код',
                  onPressed: () => widget.onResend?.call(),
                )
              else
                AppButton(
                  text: 'Подтвердить',
                  onPressed: () {
                    Navigator.of(context).pushNamed('/profile');
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
