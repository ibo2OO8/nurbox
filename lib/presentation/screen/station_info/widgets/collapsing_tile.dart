import 'package:flutter/cupertino.dart';

class CollapsingTile extends StatelessWidget {
  const CollapsingTile({
    super.key,
    required this.progress,
    required this.child,
  });

  final double progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final t = progress.clamp(0.0, 1.0).toDouble();
    if (t >= 1) return const SizedBox.shrink();

    return IgnorePointer(
      ignoring: t > 0.5,
      child: ClipRect(
        child: Align(
          alignment: Alignment.topCenter,
          heightFactor: 1 - t,
          child: Opacity(
            opacity: 1 - t,
            child: FractionalTranslation(
              translation: Offset(0, -t),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
