import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/crayon_theme.dart';

class WobblyBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double wobbleAmount;

  WobblyBorderPainter({
    this.color = CrayonTheme.darkBrown,
    this.strokeWidth = 3.0,
    this.wobbleAmount = 4.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    final random = math.Random(42);
    final segments = 40;
    final step = size.width / segments;

    // Top edge with wobble
    for (int i = 0; i <= segments; i++) {
      final x = i * step;
      final wobble = (random.nextDouble() - 0.5) * wobbleAmount;
      final y = wobble;
      
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    // Right edge with wobble
    final rightStep = size.height / segments;
    for (int i = 1; i <= segments; i++) {
      final y = i * rightStep;
      final wobble = (random.nextDouble() - 0.5) * wobbleAmount;
      final x = size.width + wobble;
      
      path.lineTo(x, y);
    }

    // Bottom edge with wobble
    for (int i = segments - 1; i >= 0; i--) {
      final x = i * step;
      final wobble = (random.nextDouble() - 0.5) * wobbleAmount;
      final y = size.height + wobble;
      
      path.lineTo(x, y);
    }

    // Left edge with wobble
    for (int i = segments - 1; i > 0; i--) {
      final y = i * rightStep;
      final wobble = (random.nextDouble() - 0.5) * wobbleAmount;
      final x = wobble;
      
      path.lineTo(x, y);
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(WobblyBorderPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.strokeWidth != strokeWidth ||
      oldDelegate.wobbleAmount != wobbleAmount;
}

