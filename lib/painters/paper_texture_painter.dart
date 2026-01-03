import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/crayon_theme.dart';

class PaperTexturePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = CrayonTheme.cream.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final random = math.Random(42); // Fixed seed for consistency
    
    // Draw paper texture with subtle noise
    for (int i = 0; i < 200; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 2;
      final opacity = random.nextDouble() * 0.1;
      
      paint.color = Colors.brown.withOpacity(opacity);
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
    
    // Add some subtle lines like paper grain
    paint.color = Colors.brown.withOpacity(0.05);
    paint.strokeWidth = 0.5;
    for (int i = 0; i < 30; i++) {
      final y = random.nextDouble() * size.height;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(PaperTexturePainter oldDelegate) => false;
}

