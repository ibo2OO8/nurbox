import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';

class ErrorStateScreen extends StatelessWidget {
  const ErrorStateScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.primaryButtonText,
    this.onPrimaryButtonTap,
    this.secondaryButtonText,
    this.onSecondaryButtonTap,
    this.onBack,
    this.icon = Icons.warning_amber_rounded,
  });

  final String title;
  final String subtitle;

  final IconData icon;

  /// Нижняя жёлтая кнопка — обязательная.
  final String primaryButtonText;
  final VoidCallback? onPrimaryButtonTap;

  /// Серая кнопка над жёлтой — необязательная,
  /// если null, вторая кнопка просто не показывается.
  final String? secondaryButtonText;
  final VoidCallback? onSecondaryButtonTap;

  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Назад
              GestureDetector(
                onTap: onBack ?? () => Navigator.of(context).maybePop(),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: AppColors.primaryText,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Иконка-предупреждение
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: AppColors.primaryOn, size: 30),
              ),
              const SizedBox(height: 20),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryText,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.4,
                  color: AppColors.secondaryText,
                ),
              ),

              const Spacer(),

              // Кнопки
              if (secondaryButtonText != null) ...[
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: onSecondaryButtonTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.surface,
                      foregroundColor: AppColors.primaryText,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      secondaryButtonText!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: onPrimaryButtonTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.primaryOn,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    primaryButtonText,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
