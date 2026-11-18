import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';
import 'package:nurbox/core/widgets/app_button.dart';

class HowToChargeScreen extends StatelessWidget {
  final VoidCallback? onConfirm;

  const HowToChargeScreen({super.key, this.onConfirm});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              // Заголовок
              const Text(
                'Как взять заряд?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryText,
                  height: 1.25,
                ),
              ),

              const SizedBox(height: 6),

              // Подзаголовок
              const Text(
                'Три шага — и телефон заряжается',
                style: TextStyle(fontSize: 14, color: AppColors.secondaryText),
              ),

              // Иллюстрация
              Expanded(
                flex: 5,
                child: Center(
                  child: Image.asset('assets/icons/qr_and_station.png'),
                ),
              ),

              // Шаги
              const _InstructionStep(
                number: '1',
                text: 'Выберите станцию на карте',
              ),
              const SizedBox(height: 14),

              const _InstructionStep(
                number: '2',
                text: 'Сканируйте QR-код на станции',
              ),
              const SizedBox(height: 14),

              const _InstructionStep(
                number: '3',
                text: 'Вставьте пауэрбанк в свободный слот',
              ),

              const Spacer(),

              AppButton(
                text: "Понятно",
                onPressed: () {
                  Navigator.of(context).pushNamed("/map");
                },
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _InstructionStep extends StatelessWidget {
  final String number;
  final String text;

  const _InstructionStep({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: Text(
            number,
            style: const TextStyle(
              color: AppColors.primaryOn,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.primaryText,
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }
}
