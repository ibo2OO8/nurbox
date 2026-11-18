import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';

class TooManyAttemptsView extends StatelessWidget {
  const TooManyAttemptsView({
    super.key,
    this.note = 'Для безопасности подождите 15 минут',
    this.onChangePhone,
  });

  final String note;
  final VoidCallback? onChangePhone;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          note,
          style: const TextStyle(fontSize: 12, color: AppColors.secondaryText),
        ),
        const SizedBox(height: 12),
        //   ChangePhoneLink(onTap: onChangePhone),
      ],
    );
  }
}
