import 'package:flutter/material.dart';
import 'package:nurbox/core/widgets/app_button.dart';
import 'package:nurbox/core/widgets/screen_header.dart';

import 'station_item.dart';
import 'widgets/station_tile.dart';

class ReturnStationsScreen extends StatefulWidget {
  const ReturnStationsScreen({
    super.key,
    this.title = 'Куда вернуть',
    this.subtitle = 'Станции со свободными ячейками',
    this.stations = defaultStations,
    this.buttonText = 'Показать на карте',
    this.onShowOnMap,
  });

  static const defaultStations = [
    StationItem(
      name: 'Рудаки, 42',
      details: '№ 108 · 120 м',
      status: '4 ячейки свободны · 2 занятые',
    ),
    StationItem(
      name: 'Айни, 18',
      details: '№ 305 · 900 м',
      status: '5 ячеек свободны · 1 занята',
    ),
    StationItem(
      name: 'Сомони, 12',
      details: '№ 214 · 450 м',
      status: 'Мест нет · 6 ячеек заняты',
      available: false,
    ),
  ];

  final String title;
  final String subtitle;
  final List<StationItem> stations;
  final String buttonText;

  final ValueChanged<StationItem>? onShowOnMap;

  @override
  State<ReturnStationsScreen> createState() => _ReturnStationsScreenState();
}

class _ReturnStationsScreenState extends State<ReturnStationsScreen> {
  int? _selected;

  @override
  void initState() {
    super.initState();
    final first = widget.stations.indexWhere((s) => s.available);
    _selected = first == -1 ? null : first;
  }

  void _onShowOnMap() {
    final index = _selected;
    if (index == null) return;
    widget.onShowOnMap?.call(widget.stations[index]);
  }

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
              ScreenHeader(title: widget.title, subtitle: widget.subtitle),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.separated(
                  itemCount: widget.stations.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return StationTile(
                      item: widget.stations[index],
                      selected: index == _selected,
                      onTap: () => setState(() => _selected = index),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              AppButton(text: widget.buttonText, onPressed: _onShowOnMap),
            ],
          ),
        ),
      ),
    );
  }
}
