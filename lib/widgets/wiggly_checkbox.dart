import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/crayon_theme.dart';

class WigglyCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final double size;

  const WigglyCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.size = 32.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged?.call(!value),
      child: CustomPaint(
        size: Size(size, size),
        painter: _WigglyCheckboxPainter(
          checked: value,
          color: value ? CrayonTheme.forestGreen : CrayonTheme.darkBrown,
        ),
      ),
    );
  }
}

class _WigglyCheckboxPainter extends CustomPainter {
  final bool checked;
  final Color color;

  _WigglyCheckboxPainter({
    required this.checked,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(42);
    final padding = 2.0;
    final rect = Rect.fromLTWH(padding, padding, size.width - padding * 2, size.height - padding * 2);
    
    // Draw wobbly border
    final borderPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final segments = 16;
    final width = rect.width;
    final height = rect.height;
    
    // Top edge
    for (int i = 0; i <= segments; i++) {
      final x = rect.left + (i / segments) * width;
      final wobble = (random.nextDouble() - 0.5) * 2.5;
      final y = rect.top + wobble;
      
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    
    // Right edge
    for (int i = 1; i <= segments; i++) {
      final y = rect.top + (i / segments) * height;
      final wobble = (random.nextDouble() - 0.5) * 2.5;
      final x = rect.right + wobble;
      path.lineTo(x, y);
    }
    
    // Bottom edge
    for (int i = segments - 1; i >= 0; i--) {
      final x = rect.left + (i / segments) * width;
      final wobble = (random.nextDouble() - 0.5) * 2.5;
      final y = rect.bottom + wobble;
      path.lineTo(x, y);
    }
    
    // Left edge
    for (int i = segments - 1; i > 0; i--) {
      final y = rect.top + (i / segments) * height;
      final wobble = (random.nextDouble() - 0.5) * 2.5;
      final x = rect.left + wobble;
      path.lineTo(x, y);
    }
    
    path.close();
    
    if (checked) {
      // Fill with light color
      final fillPaint = Paint()
        ..color = color.withOpacity(0.2)
        ..style = PaintingStyle.fill;
      canvas.drawPath(path, fillPaint);
    }
    
    canvas.drawPath(path, borderPaint);

    // Draw checkmark if checked (also wobbly)
    if (checked) {
      final checkPaint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.0
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;

      final checkPath = Path();
      final centerX = size.width / 2;
      final centerY = size.height / 2;
      
      // Wobbly checkmark
      checkPath.moveTo(centerX - size.width * 0.2, centerY);
      checkPath.quadraticBezierTo(
        centerX - size.width * 0.05 + (random.nextDouble() - 0.5) * 2,
        centerY + size.width * 0.1 + (random.nextDouble() - 0.5) * 2,
        centerX + size.width * 0.25 + (random.nextDouble() - 0.5) * 2,
        centerY - size.width * 0.15 + (random.nextDouble() - 0.5) * 2,
      );
      
      canvas.drawPath(checkPath, checkPaint);
    }
  }

  @override
  bool shouldRepaint(_WigglyCheckboxPainter oldDelegate) =>
      oldDelegate.checked != checked || oldDelegate.color != color;
}

