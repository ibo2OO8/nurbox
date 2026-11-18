import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';
import 'package:nurbox/core/widgets/app_button.dart';

class TariffContainerCard extends StatelessWidget {
  final String tariffInfo;
  final VoidCallback? onTap;

  const TariffContainerCard({super.key, required this.tariffInfo, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.credit_card_outlined,
                      color: AppColors.secondaryText,
                      size: 22,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        tariffInfo,
                        style: const TextStyle(
                          color: AppColors.primaryText,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.secondaryText,
                      size: 22,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                AppButton(
                  icon: Icons.qr_code_scanner,
                  text: "Сканировать",
                  onPressed: () {
                    Navigator.of(context).pushNamed('/qr_code');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
