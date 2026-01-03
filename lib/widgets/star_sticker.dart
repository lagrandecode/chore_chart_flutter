import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/crayon_theme.dart';

class StarSticker extends StatelessWidget {
  final double size;
  final bool shiny;

  const StarSticker({
    super.key,
    this.size = 40.0,
    this.shiny = true,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _StarStickerPainter(shiny: shiny),
    );
  }
}

class _StarStickerPainter extends CustomPainter {
  final bool shiny;

  _StarStickerPainter({required this.shiny});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width / 2 - 2;
    final innerRadius = outerRadius * 0.4;
    final points = 5;
    
    // Draw wobbly star
    final path = Path();
    final random = math.Random(42);
    
    for (int i = 0; i < points * 2; i++) {
      final angle = (i * math.pi) / points - math.pi / 2;
      final radius = i.isEven ? outerRadius : innerRadius;
      final wobble = (random.nextDouble() - 0.5) * 2;
      final r = radius + wobble;
      final x = center.dx + r * math.cos(angle);
      final y = center.dy + r * math.sin(angle);
      
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    // Fill with gradient for shiny effect
    if (shiny) {
      final gradient = RadialGradient(
        colors: [
          CrayonTheme.goldenYellow,
          CrayonTheme.mustardYellow,
          CrayonTheme.mustardYellow.withOpacity(0.8),
        ],
        stops: const [0.0, 0.5, 1.0],
      );
      final fillPaint = Paint()
        ..shader = gradient.createShader(
          Rect.fromCircle(center: center, radius: outerRadius),
        )
        ..style = PaintingStyle.fill;
      canvas.drawPath(path, fillPaint);
    } else {
      final fillPaint = Paint()
        ..color = CrayonTheme.mustardYellow
        ..style = PaintingStyle.fill;
      canvas.drawPath(path, fillPaint);
    }

    // Draw border
    final borderPaint = Paint()
      ..color = CrayonTheme.darkBrown
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, borderPaint);

    // Add shine effect
    if (shiny) {
      final shinePaint = Paint()
        ..color = Colors.white.withOpacity(0.6)
        ..style = PaintingStyle.fill;
      
      final shinePath = Path();
      shinePath.moveTo(center.dx - size.width * 0.1, center.dy - size.width * 0.2);
      shinePath.lineTo(center.dx - size.width * 0.05, center.dy - size.width * 0.3);
      shinePath.lineTo(center.dx + size.width * 0.05, center.dy - size.width * 0.2);
      shinePath.close();
      canvas.drawPath(shinePath, shinePaint);
    }
  }

  @override
  bool shouldRepaint(_StarStickerPainter oldDelegate) => false;
}

