import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';
import 'package:nurbox/core/widgets/app_button.dart';

/// Общий каркас экранов оплаты: назад → иконка → заголовок → подзаголовок → контент → кнопки снизу.
class PaymentScaffold extends StatelessWidget {
  const PaymentScaffold({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.body,
    this.bottom,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? body;
  final Widget? bottom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _BackButton(),
              SizedBox(height: leading != null ? 28 : 20),
              if (leading != null) ...[leading!, const SizedBox(height: 20)],
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryText,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 8),
                Text(
                  subtitle!,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    color: AppColors.secondaryText,
                  ),
                ),
              ],
              const SizedBox(height: 20),
              Expanded(
                child: body == null
                    ? const SizedBox.shrink()
                    : SingleChildScrollView(child: body),
              ),
              if (bottom != null) ...[const SizedBox(height: 12), bottom!],
            ],
          ),
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Navigator.of(context).maybePop(),
        child: const SizedBox(
          width: 40,
          height: 40,
          child: Icon(
            Icons.arrow_back_rounded,
            size: 20,
            color: AppColors.primaryText,
          ),
        ),
      ),
    );
  }
}

/// Жёлтый квадрат с иконкой (warning / check).
class PaymentStatusIcon extends StatelessWidget {
  const PaymentStatusIcon.warning({super.key})
    : icon = Icons.warning_amber_rounded;

  const PaymentStatusIcon.success({super.key}) : icon = Icons.check_rounded;

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(icon, size: 24, color: AppColors.primaryOn),
    );
  }
}

/// Серая вторичная кнопка (жёлтая — ваш AppButton).
class AppSecondaryButton extends StatelessWidget {
  const AppSecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: AppColors.surface,
          foregroundColor: AppColors.primaryText,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        child: Text(text),
      ),
    );
  }
}

/// Пара кнопок снизу: серая сверху, жёлтая снизу.
class PaymentButtons extends StatelessWidget {
  const PaymentButtons({
    super.key,
    required this.secondaryText,
    required this.onSecondary,
    required this.primaryText,
    required this.onPrimary,
  });

  final String secondaryText;
  final VoidCallback onSecondary;
  final String primaryText;
  final VoidCallback onPrimary;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppSecondaryButton(text: secondaryText, onPressed: onSecondary),
        const SizedBox(height: 12),
        AppButton(text: primaryText, onPressed: onPrimary),
      ],
    );
  }
}
