import 'package:flutter/material.dart';
import 'package:nurbox/core/widgets/city_map_view.dart';
import 'package:nurbox/core/widgets/rental_status_banner.dart';
import 'package:nurbox/presentation/screen/return_power_bank/panels/return_station_panel.dart';
import 'package:nurbox/presentation/screen/return_power_bank/panels/return_waiting_panel.dart';
import 'package:nurbox/presentation/screen/station_info/panels/map_notice_panel.dart';
import 'package:nurbox/presentation/screen/station_info/panels/station_panel.dart';
import 'package:nurbox/presentation/screen/station_info/panels/station_tariff_panel.dart';
import 'package:nurbox/presentation/screen/station_info/station_data.dart';
import 'package:nurbox/presentation/screen/take_power_bank/map/map_panel/map_bottom_panel.dart';
import 'package:nurbox/presentation/screen/take_power_bank/map/qr_read_panel/qr_read_panel.dart';
import 'package:nurbox/presentation/screen/take_power_bank/map/rental_panel/rental_panel.dart';

enum MapPanel {
  main(size: 0.35, label: 'Nurbox'), // 0
  station(
    size: 0.47,
    minSize: 0.47,
    maxSize: 0.95,
    label: 'Nurbox',
  ), // 1 станция, тянется
  qrRead(size: 0.70, label: 'QR считан'), // 2
  rental(size: 0.43, label: 'QR считан'), // 3

  returnStation(
    size: 0.36,
    label: 'Nurbox',
  ), // 4 станция со свободными ячейками
  returnUnavailable(size: 0.36, label: 'Nurbox'), // 5 станция без мест
  returnChecking(size: 0.40, label: 'Nurbox'), // 6 ждём подтверждение

  // Станции (тянутся от 0.41 до 0.95)
  partnerStation(
    size: 0.41,
    minSize: 0.41,
    maxSize: 0.95,
    label: 'Nurbox',
  ), // 7
  regularStation(
    size: 0.41,
    minSize: 0.41,
    maxSize: 0.95,
    label: 'Nurbox',
  ), // 8
  stationTariff(size: 0.55, label: 'Nurbox'), // 9 тариф с крестиком

  // Если станции показать нельзя
  locationDenied(size: 0.30, label: 'Nurbox'), // 10 нужна геолокация
  offline(size: 0.30, label: 'Nurbox'), // 11 нет соединения
  noStations(size: 0.30, label: 'Nurbox'); // 12 рядом нет станций

  const MapPanel({
    required this.size,
    required this.label,
    double? minSize,
    double? maxSize,
  }) : minSize = minSize ?? size,
       maxSize = maxSize ?? size;

  final double size;
  final double minSize;
  final double maxSize;
  final String label;

  bool get isReturn =>
      this == returnStation ||
      this == returnUnavailable ||
      this == returnChecking;

  bool get isStation =>
      this == station || this == partnerStation || this == regularStation;
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapPanel _panel = MapPanel.main;
  bool _initialized = false;

  MapPanel _lastStation = MapPanel.partnerStation;

  double _sheetSize = MapPanel.main.size;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;
    _initialized = true;

    final value = ModalRoute.of(context)?.settings.arguments as int?;
    if (value != null && value >= 0 && value < MapPanel.values.length) {
      _setPanel(MapPanel.values[value], rebuild: false);
    }
  }

  void _setPanel(MapPanel panel, {bool rebuild = true}) {
    void apply() {
      _panel = panel;
      _sheetSize = panel.size;
      if (panel.isStation) _lastStation = panel;
    }

    if (rebuild) {
      setState(apply);
    } else {
      apply();
    }
  }

  bool _onSheetMoved(DraggableScrollableNotification n) {
    final size = n.extent.clamp(0.0, _panel.size).toDouble();
    if ((size - _sheetSize).abs() < 0.001) return false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() => _sheetSize = size);
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final panelHeight = constraints.maxHeight * _sheetSize;
          return Stack(
            children: [
              Positioned.fill(
                child: CityMapView(
                  onProfileTap: () {
                    Navigator.of(context).pushNamed('/profile');
                  },
                  label: _panel.label,
                  onLocateTap: () {
                    debugPrint('get location');
                  },
                  onMapTap: (point, coordinates) {
                    // Пока идёт возврат, нажатия на карту ничего не меняют.
                    if (_panel.isReturn) return;
                    _setPanel(MapPanel.station);
                  },
                  bottomOffset: panelHeight + 16,

                  onBackTap: _panel.isReturn
                      ? () => _setPanel(MapPanel.rental)
                      : null,
                  // Профиль скрыт на панелях возврата
                  showProfileButton: !_panel.isReturn,

                  topBanner: _panel == MapPanel.returnChecking
                      ? const RentalStatusBanner(
                          title: 'Проверяем возврат',
                          subtitle: 'Аренда пока активна',
                        )
                      : null,
                ),
              ),
              NotificationListener<DraggableScrollableNotification>(
                onNotification: _onSheetMoved,
                child: DraggableScrollableSheet(
                  key: ValueKey(_panel),
                  initialChildSize: _panel.size,
                  minChildSize: _panel.minSize,
                  maxChildSize: _panel.maxSize,
                  snap: true,
                  builder: (context, scrollController) {
                    return switch (_panel) {
                      MapPanel.main => MapBottomPanel(
                        scrollController: scrollController,
                        onInstructionTap: () =>
                            Navigator.of(context).pushNamed('/help'),
                        onScanQrTap: () =>
                            Navigator.of(context).pushNamed('/qr_code'),
                      ),
                      MapPanel.station => StationPanel(
                        scrollController: scrollController,
                        restFraction: _panel.minSize, // <-- добавлено
                        onTariffTap: () => _setPanel(MapPanel.stationTariff),
                      ),
                      MapPanel.qrRead => const QrReadPanel(),
                      MapPanel.rental => RentalPanel(
                        onDetails: () =>
                            Navigator.of(context).pushNamed('/rental_details'),
                      ),
                      MapPanel.returnStation => ReturnStationPanel(
                        scrollController: scrollController,
                        onCheck: () =>
                            Navigator.of(context).pushNamed('/return_checking'),
                        onAllStations: () =>
                            Navigator.of(context).pushNamed('/return_stations'),
                      ),
                      MapPanel.returnUnavailable =>
                        ReturnStationPanel.unavailable(
                          scrollController: scrollController,
                          onFindAnother: () =>
                              Navigator.of(context)
                                  .pushNamed('/return_stations'),
                        ),
                      MapPanel.returnChecking => ReturnWaitingPanel(
                        scrollController: scrollController,
                        onCheck: () =>
                            Navigator.of(context).pushNamed('/return_checking'),
                        onDetails: () =>
                            Navigator.of(context).pushNamed('/rental_details'),
                      ),

                      MapPanel.partnerStation => StationPanel(
                        scrollController: scrollController,
                        restFraction: _panel.minSize, // <-- добавлено
                        onTariffTap: () => _setPanel(MapPanel.stationTariff),
                      ),

                      MapPanel.regularStation => StationPanel(
                        station: StationData.regular,
                        scrollController: scrollController,
                        restFraction: _panel.minSize, // <-- добавлено
                        onTariffTap: () => _setPanel(MapPanel.stationTariff),
                      ),

                      MapPanel.stationTariff => StationTariffPanel(
                        onClose: () => _setPanel(_lastStation),
                      ),

                      MapPanel.locationDenied => MapNoticePanel.location(
                        onAction: () => debugPrint('request location'),
                      ),
                      MapPanel.offline => MapNoticePanel.offline(
                        onAction: () => debugPrint('retry connection'),
                      ),
                      MapPanel.noStations => MapNoticePanel.noStations(
                        onAction: () => _setPanel(MapPanel.main),
                      ),
                    };
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
