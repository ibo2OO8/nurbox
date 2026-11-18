import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';

class StationSheetSurface extends StatelessWidget {
  const StationSheetSurface({
    super.key,
    required this.children,
    this.bottom,
    this.scrollController,
    this.color,
    this.bottomOverlap = 28,
  });

  final List<Widget> children;
  final Widget? bottom;
  final ScrollController? scrollController;

  final Color? color;

  final double bottomOverlap;

  @override
  Widget build(BuildContext context) {
    final overlap = bottom == null ? 0.0 : bottomOverlap;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(28),
        bottom: Radius.circular(28),
      ),
      child: ColoredBox(
        color: color ?? AppColors.surface,
        child: SafeArea(
          top: false,
          bottom: bottom == null,
          child: Column(
            children: [
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final h = constraints.maxHeight + overlap;
                    return OverflowBox(
                      alignment: Alignment.topCenter,
                      minHeight: h,
                      maxHeight: h,
                      child: ListView(
                        controller: scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        // компенсирует заход под панель, чтобы
                        // контент остался на прежних местах
                        padding: EdgeInsets.only(bottom: overlap),
                        children: children,
                      ),
                    );
                  },
                ),
              ),
              if (bottom != null) bottom!,
            ],
          ),
        ),
      ),
    );
  }
}
