import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';

class ScanFrame extends StatelessWidget {
  const ScanFrame({super.key, this.size = 150});

  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size.square(size), painter: _ScanFramePainter());
  }
}

class _ScanFramePainter extends CustomPainter {
  static const double _corner = 28;
  static const double _radius = 6;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;

    final path = Path()
      // верхний левый
      ..moveTo(0, _corner)
      ..lineTo(0, _radius)
      ..quadraticBezierTo(0, 0, _radius, 0)
      ..lineTo(_corner, 0)
      // верхний правый
      ..moveTo(w - _corner, 0)
      ..lineTo(w - _radius, 0)
      ..quadraticBezierTo(w, 0, w, _radius)
      ..lineTo(w, _corner)
      // нижний правый
      ..moveTo(w, h - _corner)
      ..lineTo(w, h - _radius)
      ..quadraticBezierTo(w, h, w - _radius, h)
      ..lineTo(w - _corner, h)
      // нижний левый
      ..moveTo(_corner, h)
      ..lineTo(_radius, h)
      ..quadraticBezierTo(0, h, 0, h - _radius)
      ..lineTo(0, h - _corner);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
