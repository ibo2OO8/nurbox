import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';
import 'package:nurbox/core/widgets/app_button.dart';
import 'package:nurbox/core/widgets/square_icon_button.dart';
import 'package:nurbox/presentation/screen/take_power_bank/pickup_power_bank/widgets/info_banner.dart';

class PickupPowerBankScreen extends StatelessWidget {
  const PickupPowerBankScreen({
    super.key,
    this.slotNumber = 3,
    this.image,
    this.title = 'Заберите пауэрбанк',
    this.bannerTitle = 'Возьмите устройство из слота',
    this.bannerSubtitle = 'Аренда начнётся после выдачи',
    this.slotNotOpenedText = 'Слот не открылся?',

    this.onSlotNotOpened,
    this.onTaken,
  });

  final int slotNumber;
  final ImageProvider? image;
  final String title;
  final String bannerTitle;
  final String bannerSubtitle;
  final String slotNotOpenedText;
  final VoidCallback? onSlotNotOpened;
  final VoidCallback? onTaken;

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
              ///asdsa
              SquareIconButton(
                icon: Icons.arrow_back,
                onPressed: () {
                  Navigator.of(context).maybePop();
                },
              ),
              const SizedBox(height: 24),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  height: 1.2,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryText,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Слот №$slotNumber открылся на станции',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.secondaryText,
                ),
              ),
              const SizedBox(height: 24),

              Image.asset('assets/icons/power_bank.png'),

              const SizedBox(height: 16),
              InfoBanner(title: bannerTitle, subtitle: bannerSubtitle),
              const SizedBox(height: 8),
              Center(
                child: TextButton(
                  onPressed: onSlotNotOpened,
                  child: Text(
                    slotNotOpenedText,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.secondaryText,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              AppButton(
                text: 'Пауэрбанк забран',
                onPressed: () {
                  Navigator.of(context).pushNamed("/map" , arguments: 3);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
