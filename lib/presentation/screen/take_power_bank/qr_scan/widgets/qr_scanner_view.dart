import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';
import 'package:nurbox/presentation/screen/take_power_bank/qr_scan/widgets/scan_frame.dart';

class QrScannerView extends StatefulWidget {
  const QrScannerView({super.key, this.onScanned});

  final ValueChanged<String>? onScanned;

  @override
  State<QrScannerView> createState() => _QrScannerViewState();
}

class _QrScannerViewState extends State<QrScannerView> {
  final MobileScannerController _controller = MobileScannerController(
    formats: const [BarcodeFormat.qrCode],
  );
  bool _handled = false;

  void _onDetect(BarcodeCapture capture) {
    if (_handled) return;
    final value = capture.barcodes
        .map((b) => b.rawValue)
        .whereType<String>()
        .firstOrNull;
    if (value == null || value.isEmpty) return;
    _handled = true;
    widget.onScanned?.call(value);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: Stack(
        fit: StackFit.expand,
        children: [
          const ColoredBox(color: AppColors.mapBadge),
          MobileScanner(
            controller: _controller,
            onDetect: _onDetect,
            errorBuilder: (context, error, child) => const Center(
              child: Icon(
                Icons.no_photography_outlined,
                color: Colors.white54,
                size: 40,
              ),
            ),
          ),
          const Center(child: ScanFrame()),
        ],
      ),
    );
  }
}
