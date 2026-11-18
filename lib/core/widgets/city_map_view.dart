import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';

class CityMapView extends StatefulWidget {
  const CityMapView({
    super.key,
    this.label = 'Nurbox',
    this.initialCameraPosition = const CameraPosition(
      target: LatLng(38.5598, 68.7870),
      zoom: 14,
    ),
    this.styleString = 'https://tiles.openfreemap.org/styles/liberty',
    this.onProfileTap,
    this.onLocateTap,
    this.onBackTap,
    this.showProfileButton = true,
    this.topBanner,
    this.onMapCreated,
    this.onMapTap,
    required this.bottomOffset,
  });

  final String label;
  final double bottomOffset;
  final CameraPosition initialCameraPosition;
  final String styleString;
  final VoidCallback? onProfileTap;

  final VoidCallback? onLocateTap;

  final VoidCallback? onBackTap;

  final bool showProfileButton;

  final Widget? topBanner;

  final void Function(MaplibreMapController controller)? onMapCreated;

  final void Function(Point<double> point, LatLng coordinates)? onMapTap;

  @override
  State<CityMapView> createState() => _CityMapViewState();
}

class _CityMapViewState extends State<CityMapView> {
  MaplibreMapController? _controller;

  bool _showMyLocation = false;
  bool _locating = false;

  void _handleMapCreated(MaplibreMapController controller) {
    _controller = controller;
    widget.onMapCreated?.call(controller);
  }

  void _showMessage(String text, {String? action, VoidCallback? onAction}) {
    if (!mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(text),
          action: action == null
              ? null
              : SnackBarAction(label: action, onPressed: onAction ?? () {}),
        ),
      );
  }

  Future<void> _onLocatePressed() async {
    widget.onLocateTap?.call();
    if (_locating) return;
    _locating = true;

    try {
      // 1. Геолокация включена на телефоне?
      if (!await Geolocator.isLocationServiceEnabled()) {
        _showMessage(
          'Включите геолокацию на телефоне',
          action: 'Настройки',
          onAction: Geolocator.openLocationSettings,
        );
        return;
      }

      // 2. Разрешение: при первом нажатии появится системный диалог.
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied) {
        _showMessage('Нужен доступ к геолокации, чтобы показать вас на карте');
        return;
      }
      if (permission == LocationPermission.deniedForever) {
        _showMessage(
          'Доступ запрещён. Разрешите его в настройках приложения',
          action: 'Настройки',
          onAction: Geolocator.openAppSettings,
        );
        return;
      }

      // 3. Показываем синюю точку и летим к пользователю.
      if (!mounted) return;
      setState(() => _showMyLocation = true);

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );

      await _controller?.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(position.latitude, position.longitude),
          16,
        ),
      );
    } catch (_) {
      _showMessage('Не удалось определить местоположение');
    } finally {
      _locating = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: MaplibreMap(
            styleString: widget.styleString,
            initialCameraPosition: widget.initialCameraPosition,
            onMapCreated: _handleMapCreated,
            onMapClick: widget.onMapTap,
            myLocationEnabled: _showMyLocation,
            compassEnabled: false,
            trackCameraPosition: true,
          ),
        ),

        // Верхняя панель: либо плашка, либо [назад или название] + профиль
        if (widget.topBanner != null)
          Positioned(top: 50, left: 16, right: 16, child: widget.topBanner!)
        else ...[
          if (widget.showProfileButton)
            Positioned(
              top: 50,
              right: 16,
              child: _RoundIconButton(
                icon: Icons.person_outlined,
                onTap: widget.onProfileTap,
                height: 52,
                radius: 18,
              ),
            ),
          if (widget.onBackTap != null)
            Positioned(
              top: 50,
              left: 16,
              height: 52,
              child: _RoundIconButton(
                icon: Icons.arrow_back,
                onTap: widget.onBackTap,
                radius: 18,
              ),
            )
          else
            Positioned(
              left: 16,
              top: 50,
              child: Container(
                alignment: Alignment.centerLeft,
                width: 164,
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: EdgeInsetsGeometry.only(left: 18),
                  child: Text(
                    widget.label,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: AppColors.secondaryText,
                    ),
                  ),
                ),
              ),
            ),
        ],

        AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          right: 16,
          bottom: widget.bottomOffset,
          child: _RoundIconButton(
            icon: Icons.my_location,
            onTap: _onLocatePressed,
            radius: 16,
          ),
        ),
      ],
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({
    required this.icon,
    this.onTap,
    this.height = 46,
    required this.radius,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
    );
    return Material(
      color: Colors.white,
      elevation: 4,
      shape: shape,
      child: InkWell(
        customBorder: shape,
        onTap: onTap,
        child: SizedBox(
          height: height,
          width: 46,
          child: Icon(icon, size: 24, color: Colors.black87),
        ),
      ),
    );
  }
}
