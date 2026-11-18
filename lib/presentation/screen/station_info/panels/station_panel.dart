import 'package:flutter/material.dart';
import 'package:nurbox/core/widgets/app_button.dart';
import 'package:nurbox/presentation/screen/station_info/widgets/collapsing_tile.dart';

import '../station_data.dart';
import '../widgets/how_it_works_card.dart';
import '../widgets/station_header.dart';
import '../widgets/station_sheet_surface.dart';
import '../widgets/tariff_card.dart';
import '../widgets/tariff_summary_tile.dart';

class StationPanel extends StatelessWidget {
  const StationPanel({
    super.key,
    this.station = StationData.partner,
    this.tariff = TariffData.standard,
    this.howSteps = HowItWorksCard.defaultSteps,
    this.scrollController,
    this.onTariffTap,
    this.restFraction = 0.41,
  });

  final StationData station;
  final TariffData tariff;
  final List<HowStep> howSteps;
  final ScrollController? scrollController;
  final VoidCallback? onTariffTap;
  final double restFraction;

  static const _threshold = 0.62;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return LayoutBuilder(
      builder: (context, constraints) {
        final h = constraints.maxHeight;
        final collapsed = h < screenHeight * _threshold;

        final from = screenHeight * restFraction;
        final to = screenHeight * _threshold;
        final progress = to > from
            ? ((h - from) / (to - from)).clamp(0.0, 1.0).toDouble()
            : 1.0;

        return StationSheetSurface(
          scrollController: scrollController,
          bottom: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (collapsed)
                    CollapsingTile(
                      progress: progress,
                      child: TariffSummaryTile(
                        text: tariff.summary,
                        onTap: onTariffTap,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    child: AppButton(
                      text: 'Сканировать',
                      onPressed: () =>
                          Navigator.of(context).pushNamed('/qr_code'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          children: [
            StationHeader(station: station, showPhotos: !collapsed),
            if (!collapsed) ...[
              const SizedBox(height: 9),
              TariffCard(tariff: tariff),
              const SizedBox(height: 9),
              HowItWorksCard(steps: howSteps),
            ],
          ],
        );
      },
    );
  }
}
