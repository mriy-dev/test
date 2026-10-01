import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:webspark/core/extensions/theme_extension.dart';

class ProgressRing extends StatelessWidget {
  const ProgressRing({
    super.key,
    required this.progress,
    this.size = 72,
    this.strokeWidth = 2,
    this.duration = const Duration(milliseconds: 250),
  });

  final double progress;
  final double size;
  final double strokeWidth;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(end: progress.clamp(0.0, 1.0)),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, value, _) => CustomPaint(
        size: Size.square(size),
        painter: _RingPainter(
          progress: value,
          color: context.colors.primary,
          trackColor: context.colors.primary.withValues(alpha: 0.15),
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  const _RingPainter({
    required this.progress,
    required this.color,
    required this.trackColor,
    required this.strokeWidth,
  });

  final double progress;
  final Color color;
  final Color trackColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2 - strokeWidth / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, stroke..color = trackColor);
    if (progress > 0) {
      canvas.drawArc(rect, -math.pi / 2, 2 * math.pi * progress, false, stroke..color = color);
    }
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.progress != progress ||
      old.color != color ||
      old.trackColor != trackColor ||
      old.strokeWidth != strokeWidth;
}
