import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';
import 'package:nurbox/core/widgets/app_button.dart';
import 'package:nurbox/core/widgets/screen_header.dart';

import 'widgets/request_field.dart';

/// Экран «Заявка на партнёрство»: название, адрес и номер.
class PartnerRequestScreen extends StatefulWidget {
  const PartnerRequestScreen({
    super.key,
    this.title = 'Заявка на партнёрство',
    this.subtitle =
        'Расскажите о заведении. Команда Nurbox свяжется с вами по указанному номеру.',
    this.nameLabel = 'Название заведения',
    this.nameHint = 'Например, Кофейня 42',
    this.addressLabel = 'Адрес точки',
    this.addressHint = 'Город, улица и номер дома',
    this.phoneLabel = 'Контактный номер',
    this.phoneHint = '+992 00 000 00 00',
    this.fillHint = 'Заполните все поля, чтобы мы могли ответить.',
    this.agreeText =
        'Нажимая «Отправить заявку», вы соглашаетесь\nна связь по этому номеру.',
    this.buttonText = 'Отправить заявку',
  });

  final String title;
  final String subtitle;
  final String nameLabel;
  final String nameHint;
  final String addressLabel;
  final String addressHint;
  final String phoneLabel;
  final String phoneHint;
  final String fillHint;
  final String agreeText;
  final String buttonText;

  @override
  State<PartnerRequestScreen> createState() => _PartnerRequestScreenState();
}

class _PartnerRequestScreenState extends State<PartnerRequestScreen> {
  final _name = TextEditingController();
  final _address = TextEditingController();
  final _phone = TextEditingController();
  bool _showErrors = false;

  @override
  void dispose() {
    _name.dispose();
    _address.dispose();
    _phone.dispose();
    super.dispose();
  }

  bool _empty(TextEditingController c) => c.text.trim().isEmpty;

  // В номере должно быть минимум 9 цифр.
  bool get _phoneInvalid =>
      _phone.text.replaceAll(RegExp(r'\D'), '').length < 9;

  /// «Отправить заявку»: если всё заполнено, открываем «Заявка принята».
  void _onSend() {
    if (_empty(_name) || _empty(_address) || _phoneInvalid) {
      setState(() => _showErrors = true);
      return;
    }
    // TODO: отправить заявку на сервер
    Navigator.of(context).pushReplacementNamed('/partner_accepted');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ScreenHeader(
                        title: widget.title,
                        subtitle: widget.subtitle,
                      ),
                      const SizedBox(height: 32),
                      RequestField(
                        label: widget.nameLabel,
                        hint: widget.nameHint,
                        controller: _name,
                        hasError: _showErrors && _empty(_name),
                      ),
                      const SizedBox(height: 16),
                      RequestField(
                        label: widget.addressLabel,
                        hint: widget.addressHint,
                        controller: _address,
                        hasError: _showErrors && _empty(_address),
                      ),
                      const SizedBox(height: 16),
                      RequestField(
                        label: widget.phoneLabel,
                        hint: widget.phoneHint,
                        controller: _phone,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9+ ]')),
                          LengthLimitingTextInputFormatter(17),
                        ],
                        hasError: _showErrors && _phoneInvalid,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.fillHint,
                        style: TextStyle(
                          fontSize: 11,
                          color: _showErrors
                              ? AppColors.danger
                              : AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.agreeText,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.secondaryText,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              AppButton(text: widget.buttonText, onPressed: _onSend),
            ],
          ),
        ),
      ),
    );
  }
}
