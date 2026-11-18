import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';
import 'package:nurbox/core/widgets/app_back_button.dart';

/// Жёлтый квадрат с иконкой или индикатором загрузки.
class StatusIconBox extends StatelessWidget {
  const StatusIconBox({super.key, this.icon, this.loading = false});

  final IconData? icon;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(14),
      ),
      child: loading
          ? const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: AppColors.primaryOn,
              ),
            )
          : Icon(icon, size: 24, color: AppColors.primaryOn),
    );
  }
}

/// Общий каркас для экранов результата возврата:
/// «Проверяем возврат», «Пауэрбанк возвращён», «Возврат не подтверждён».
///
/// Сверху иконка, потом заголовок, текст и содержимое [child].
/// Кнопки [actions] прижаты к низу экрана.
class StatusScreenLayout extends StatelessWidget {
  const StatusScreenLayout({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon,
    this.loading = false,
    this.showBack = true,
    this.onBack,
    this.child,
    this.actions = const [],
  });

  final String title;
  final String subtitle;
  final IconData? icon;

  /// true — вместо иконки крутится индикатор.
  final bool loading;
  final bool showBack;
  final VoidCallback? onBack;
  final Widget? child;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (showBack)
                      AppBackButton(onPressed: onBack)
                    else
                      const SizedBox(height: 44),
                    const SizedBox(height: 48),
                    StatusIconBox(icon: icon, loading: loading),
                    const SizedBox(height: 24),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        height: 1.2,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryText,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.4,
                        color: AppColors.secondaryText,
                      ),
                    ),
                    if (child != null) ...[
                      const SizedBox(height: 32),
                      child!,
                    ],
                    const Spacer(),
                    for (var i = 0; i < actions.length; i++) ...[
                      if (i != 0) const SizedBox(height: 12),
                      actions[i],
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
