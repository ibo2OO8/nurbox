import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';


class ReturnPanelSurface extends StatelessWidget {
  const ReturnPanelSurface({
    super.key,
    required this.child,
    this.scrollController,
  });

  final Widget child;

  /// Контроллер из DraggableScrollableSheet.
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
