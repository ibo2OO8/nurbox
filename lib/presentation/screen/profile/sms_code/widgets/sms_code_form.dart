import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';
import 'package:nurbox/presentation/screen/profile/sms_code/widgets/change_phone_link.dart';
import 'package:nurbox/presentation/screen/profile/sms_code/widgets/sms_code_status.dart';
import 'package:nurbox/presentation/screen/take_power_bank/station_code/widgets/code_box.dart';


class SmsCodeForm extends StatelessWidget {
  const SmsCodeForm({
    super.key,
    required this.status,
    required this.codeLength,
    required this.resendIn,
    this.label = 'Код из SMS',
    this.invalidCodeText = 'Неверный код. Проверьте и попробуйте ещё раз',
    this.expiredText = 'Срок действия кода истёк',
    this.onChanged,
    this.onChangePhone,
  });

  final SmsCodeStatus status;
  final int codeLength;
  final String resendIn;
  final String label;
  final String invalidCodeText;
  final String expiredText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onChangePhone;

  String? get _errorText => switch (status) {
        SmsCodeStatus.invalidCode => invalidCodeText,
        SmsCodeStatus.expired => expiredText,
        _ => null,
      };

  @override
  Widget build(BuildContext context) {
    final errorText = _errorText;
    final canResend = status != SmsCodeStatus.expired;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryText,
          ),
        ),
        const SizedBox(height: 8),
        CodeInputBoxes(length: codeLength, onChanged: onChanged),
        if (errorText != null) ...[
          const SizedBox(height: 16),
          Text(
            errorText,
            style: const TextStyle(fontSize: 12, color: AppColors.danger),
          ),
        ],
        if (canResend) ...[
          const SizedBox(height: 16),
          Text(
            'Отправить код повторно через $resendIn',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.secondaryText,
            ),
          ),
        ],
        const SizedBox(height: 12),
        ChangePhoneLink(onTap: onChangePhone),
      ],
    );
  }
}