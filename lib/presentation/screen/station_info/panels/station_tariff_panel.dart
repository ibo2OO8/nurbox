import 'package:flutter/material.dart';
import 'package:nurbox/core/widgets/app_button.dart';
import '../station_data.dart';
import '../widgets/sheet_close_button.dart';
import '../widgets/station_sheet_surface.dart';
import '../widgets/tariff_card.dart';

class StationTariffPanel extends StatelessWidget {
  const StationTariffPanel({
    super.key,
    this.title = 'Тариф',
    this.tariff = TariffData.standard,
    this.onClose,
  });

  final String title;
  final TariffData tariff;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Прозрачная полоса с крестиком над белой панелью
        Padding(
          padding: const EdgeInsets.only(right: 16, bottom: 12),
          child: Align(
            alignment: Alignment.centerRight,
            child: SheetCloseButton(onTap: onClose),
          ),
        ),
        Expanded(
          child: StationSheetSurface(
            bottom: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: AppButton(
                text: 'Сканировать',
                onPressed: () => Navigator.of(context).pushNamed('/qr_code'),
              ),
            ),
            children: [TariffCard(tariff: tariff)],
          ),
        ),
      ],
    );
  }
}
