import 'dart:math' as math;
import 'package:flutter/material.dart';

class CrayonStrokePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final List<Offset> points;

  CrayonStrokePainter({
    required this.color,
    this.strokeWidth = 4.0,
    required this.points,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Draw main stroke
    final path = Path();
    path.moveTo(points[0].dx, points[0].dy);
    
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    
    canvas.drawPath(path, paint);

    // Add texture with slightly offset strokes for crayon effect
    final random = math.Random();
    for (int i = 0; i < points.length - 1; i++) {
      if (random.nextDouble() > 0.7) {
        final offset = Offset(
          random.nextDouble() * 1.5 - 0.75,
          random.nextDouble() * 1.5 - 0.75,
        );
        paint.color = color.withOpacity(0.3);
        canvas.drawLine(
          points[i] + offset,
          points[i + 1] + offset,
          paint,
        );
        paint.color = color;
      }
    }
  }

  @override
  bool shouldRepaint(CrayonStrokePainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.strokeWidth != strokeWidth ||
      oldDelegate.points != points;
}

