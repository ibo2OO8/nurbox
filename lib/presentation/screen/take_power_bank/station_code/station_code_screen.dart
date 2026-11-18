import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';
import 'package:nurbox/core/widgets/app_button.dart';
import 'package:nurbox/presentation/screen/take_power_bank/station_code/widgets/code_box.dart';

class StationCodeScreen extends StatefulWidget {
  const StationCodeScreen({super.key, this.codeLength = 6, this.onContinue});

  final int codeLength;

  final ValueChanged<String>? onContinue;

  @override
  State<StationCodeScreen> createState() => _StationCodeScreenState();
}

class _StationCodeScreenState extends State<StationCodeScreen> {
  String _code = '';

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
              _BackButton(onPressed: () => Navigator.of(context).maybePop()),
              const SizedBox(height: 24),
              const Text(
                'Введите код станции',
                style: TextStyle(
                  fontSize: 24,
                  height: 1.2,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryText,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${widget.codeLength} цифр указаны рядом с QR-кодом',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.secondaryText,
                ),
              ),
              const SizedBox(height: 32),
              CodeInputBoxes(
                length: widget.codeLength,
                onChanged: (value) => setState(() => _code = value),
              ),
              const SizedBox(height: 16),
              const Text(
                'Проверьте код перед продолжением',
                style: TextStyle(fontSize: 12, color: AppColors.secondaryText),
              ),
              const Spacer(),
              AppButton(text: "Продолжить", onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onPressed,
        child: const SizedBox(
          width: 44,
          height: 44,
          child: Icon(Icons.arrow_back, size: 22, color: AppColors.primaryText),
        ),
      ),
    );
  }
}
