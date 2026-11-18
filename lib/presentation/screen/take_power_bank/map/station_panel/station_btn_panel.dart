import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';
import 'package:nurbox/presentation/screen/take_power_bank/map/station_panel/widgets/station_header_card.dart';
import 'package:nurbox/presentation/screen/take_power_bank/map/station_panel/widgets/tariff_container_card.dart';

class StationBtnPanel extends StatelessWidget {
  final String title;
  final String address;
  final String locationNote;
  final String workingHours;
  final String statusText;
  final int takeCount;
  final int returnCount;
  final String stationNumber;
  final String tariffInfo;
  final VoidCallback? onTariffTap;
  final VoidCallback? onScanTap;

  const StationBtnPanel({
    super.key,
    this.title = 'Кофейня 42',
    this.address = 'Душанбе, ул. Рудаки, 42',
    this.locationNote = 'Справа от входа',
    this.workingHours = 'До 22:00',
    this.statusText = 'открыто',
    this.takeCount = 6,
    this.returnCount = 4,
    this.stationNumber = '№108',
    this.tariffInfo = 'Первые 15 минут — 0 сом · залог 100 сом',
    this.onTariffTap,
    this.onScanTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface, // Серый фон карточки
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      //  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          StationHeaderCard(
            title: title,
            address: address,
            locationNote: locationNote,
            workingHours: workingHours,
            statusText: statusText,
            takeCount: takeCount,
            returnCount: returnCount,
            stationNumber: stationNumber,
          ),

          const SizedBox(height: 10),
          Expanded(
            child: TariffContainerCard(
              tariffInfo: tariffInfo,
              onTap: onTariffTap,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
