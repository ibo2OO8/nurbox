import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';
import 'package:nurbox/core/widgets/app_button.dart';

/// Пункт меню профиля: текст и стрелка справа.
class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({super.key, required this.text, this.onTap});

  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        height: 48,
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryText,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              size: 22,
              color: AppColors.primaryText,
            ),
          ],
        ),
      ),
    );
  }
}

/// Серая кнопка «Выйти из аккаунта».
class ProfileLogoutButton extends StatelessWidget {
  const ProfileLogoutButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: AppButton(
        text: 'Выйти из аккаунта',
        isSelected: false,
        onPressed: () {},
      ),
    );
  }
}
