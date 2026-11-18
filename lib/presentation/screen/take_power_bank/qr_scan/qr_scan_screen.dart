import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';
import 'package:nurbox/core/widgets/app_button.dart';
import 'package:nurbox/core/widgets/square_icon_button.dart';
import 'package:nurbox/presentation/screen/take_power_bank/qr_scan/widgets/qr_scanner_view.dart';

class QrScanScreen extends StatelessWidget {
  const QrScanScreen({
    super.key,
    this.onScanned,
    this.onManualInput,
    this.onHelp,
  });

  final ValueChanged<String>? onScanned;
  final VoidCallback? onManualInput;
  final VoidCallback? onHelp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TopBar(
                onBack: () => Navigator.of(context).maybePop(),
                onHelp: onHelp,
              ),
              const SizedBox(height: 24),
              const Text(
                'Сканируйте QR-код',
                style: TextStyle(
                  fontSize: 24,
                  height: 1.2,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryText,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Он находится на корпусе станции',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.3,
                  color: AppColors.secondaryText,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: QrScannerView(
                  onScanned: (code) {
                    Navigator.of(context)
                        .pushReplacementNamed('/map', arguments: 2);
                  },
                ),
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  'Поместите код в рамку',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.secondaryText,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _ManualInputButton(onPressed: onManualInput),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.onBack, this.onHelp});

  final VoidCallback onBack;
  final VoidCallback? onHelp;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SquareIconButton(icon: Icons.arrow_back, onPressed: onBack),
        SquareIconButton(icon: Icons.help_outline, onPressed: onHelp),
      ],
    );
  }
}

class _ManualInputButton extends StatelessWidget {
  const _ManualInputButton({this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      text: "Ввести код вручную",
      isSelected: false,
      onPressed: () {
        Navigator.of(context).pushNamed("/station_code");
      },
    );
  }
}
