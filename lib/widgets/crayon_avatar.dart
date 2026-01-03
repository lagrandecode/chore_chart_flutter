import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/family_member.dart';
import '../theme/crayon_theme.dart';

class CrayonAvatar extends StatelessWidget {
  final FamilyMember member;
  final double size;

  const CrayonAvatar({
    super.key,
    required this.member,
    this.size = 60.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _CrayonAvatarPainter(
        color: member.avatarColor,
        shape: member.avatarShape,
        name: member.name,
      ),
    );
  }
}

class _CrayonAvatarPainter extends CustomPainter {
  final Color color;
  final String shape;
  final String name;

  _CrayonAvatarPainter({
    required this.color,
    required this.shape,
    required this.name,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;
    final random = math.Random(name.hashCode); // Consistent based on name

    // Draw wobbly border for avatar shape
    final borderPaint = Paint()
      ..color = CrayonTheme.darkBrown
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    // Draw filled shape with wobble
    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final segments = 20;
    
    if (shape == 'circle') {
      for (int i = 0; i <= segments; i++) {
        final angle = (i / segments) * 2 * math.pi;
        final wobble = (random.nextDouble() - 0.5) * 3;
        final r = radius + wobble;
        final x = center.dx + r * math.cos(angle);
        final y = center.dy + r * math.sin(angle);
        
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
    } else if (shape == 'square') {
      // Draw rounded square with wobble
      final points = [
        Offset(center.dx - radius, center.dy - radius),
        Offset(center.dx + radius, center.dy - radius),
        Offset(center.dx + radius, center.dy + radius),
        Offset(center.dx - radius, center.dy + radius),
      ];
      
      for (int i = 0; i < points.length; i++) {
        final point = points[i];
        final nextPoint = points[(i + 1) % points.length];
        final wobble = (random.nextDouble() - 0.5) * 4;
        
        if (i == 0) {
          path.moveTo(point.dx + wobble, point.dy + wobble);
        }
        path.lineTo(nextPoint.dx + wobble, nextPoint.dy + wobble);
      }
    } else {
      // Triangle
      final points = [
        Offset(center.dx, center.dy - radius),
        Offset(center.dx + radius * 0.866, center.dy + radius * 0.5),
        Offset(center.dx - radius * 0.866, center.dy + radius * 0.5),
      ];
      
      for (int i = 0; i < points.length; i++) {
        final point = points[i];
        final wobble = (random.nextDouble() - 0.5) * 3;
        
        if (i == 0) {
          path.moveTo(point.dx + wobble, point.dy + wobble);
        } else {
          path.lineTo(point.dx + wobble, point.dy + wobble);
        }
      }
    }
    
    path.close();
    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, borderPaint);

    // Add simple face features
    final facePaint = Paint()
      ..color = CrayonTheme.darkBrown
      ..style = PaintingStyle.fill;

    // Eyes
    final eyeSize = size.width * 0.15;
    canvas.drawCircle(
      Offset(center.dx - size.width * 0.2, center.dy - size.width * 0.1),
      eyeSize * 0.6,
      facePaint,
    );
    canvas.drawCircle(
      Offset(center.dx + size.width * 0.2, center.dy - size.width * 0.1),
      eyeSize * 0.6,
      facePaint,
    );

    // Smile (wobbly arc)
    final smilePath = Path();
    smilePath.addArc(
      Rect.fromCenter(
        center: Offset(center.dx, center.dy + size.width * 0.05),
        width: size.width * 0.4,
        height: size.width * 0.3,
      ),
      0.2,
      1.0,
    );
    
    final smilePaint = Paint()
      ..color = CrayonTheme.darkBrown
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    
    canvas.drawPath(smilePath, smilePaint);
  }

  @override
  bool shouldRepaint(_CrayonAvatarPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.shape != shape;
}

