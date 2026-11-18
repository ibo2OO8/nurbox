import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';
import 'package:nurbox/core/widgets/app_button.dart';
import 'package:nurbox/core/widgets/screen_header.dart';
import 'package:nurbox/presentation/screen/profile/login/widgets/phone_field.dart';
import 'package:nurbox/presentation/screen/profile/login/widgets/phone_formatter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    this.title = 'Войти в Nurbox',
    this.subtitle = 'Укажите номер телефона\nПришлём код подтверждения по SMS',
    this.fieldLabel = 'Номер телефона',
    this.countryCode = '+992',
    this.hint = 'Проверьте номер перед отправкой кода',
    this.errorHint = 'Введите номер полностью',
    this.onContinue,
  });

  final String title;
  final String subtitle;
  final String fieldLabel;
  final String countryCode;
  final String hint;
  final String errorHint;

  /// Получает номер целиком, например «+992 90 123 45 67».
  final ValueChanged<String>? onContinue;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _digits = '';
  bool _showError = false;

  void _onContinue() {
    if (_digits.length != PhoneFormatter.maxDigits) {
      setState(() => _showError = true);
      return;
    }
    final phone = '${widget.countryCode} ${PhoneFormatter.format(_digits)}';
    Navigator.of(context).pushNamed('/sms_code', arguments: phone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScreenHeader(title: widget.title, subtitle: widget.subtitle),
              const SizedBox(height: 32),
              Text(
                widget.fieldLabel,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryText,
                ),
              ),
              const SizedBox(height: 8),
              PhoneField(
                countryCode: widget.countryCode,
                hasError: _showError,
                onChanged: (value) => setState(() {
                  _digits = value;
                  _showError = false;
                }),
              ),
              const SizedBox(height: 12),
              Text(
                _showError ? widget.errorHint : widget.hint,
                style: TextStyle(
                  fontSize: 12,
                  color: _showError
                      ? AppColors.danger
                      : AppColors.secondaryText,
                ),
              ),
              const Spacer(),
              AppButton(text: "Получить код", onPressed: _onContinue),
            ],
          ),
        ),
      ),
    );
  }
}
