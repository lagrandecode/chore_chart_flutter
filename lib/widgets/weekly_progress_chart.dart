import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/crayon_theme.dart';

class WeeklyProgressChart extends StatelessWidget {
  final Map<String, int> dailyProgress; // Day name -> completed tasks count
  final int maxTasks;

  const WeeklyProgressChart({
    super.key,
    required this.dailyProgress,
    this.maxTasks = 10,
  });

  @override
  Widget build(BuildContext context) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weekly Progress',
            style: CrayonTheme.childlikeBold.copyWith(fontSize: 22),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: days.map((day) {
              final count = dailyProgress[day] ?? 0;
              final height = maxTasks > 0 ? (count / maxTasks) * 150.0 : 0.0;
              
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _ProgressBar(
                        height: height,
                        color: _getDayColor(day),
                        value: count,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        day,
                        style: CrayonTheme.childlikeSmall,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Color _getDayColor(String day) {
    final colors = [
      CrayonTheme.forestGreen,
      CrayonTheme.mustardYellow,
      CrayonTheme.brickRed,
      CrayonTheme.softGreen,
      CrayonTheme.mustardYellow,
      CrayonTheme.brickRed,
      CrayonTheme.forestGreen,
    ];
    final index = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'].indexOf(day);
    return colors[index % colors.length];
  }
}

class _ProgressBar extends StatelessWidget {
  final double height;
  final Color color;
  final int value;

  const _ProgressBar({
    required this.height,
    required this.color,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    if (height < 1) {
      return const SizedBox(height: 1, width: double.infinity);
    }

    return CustomPaint(
      size: Size(double.infinity, height),
      painter: _ScribbledBarPainter(color: color, value: value),
    );
  }
}

class _ScribbledBarPainter extends CustomPainter {
  final Color color;
  final int value;

  _ScribbledBarPainter({
    required this.color,
    required this.value,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(value); // Use value for consistent randomness
    final width = size.width;
    final height = size.height;

    // Draw wobbly bar outline
    final path = Path();
    final segments = 20;
    final segmentWidth = width / segments;

    // Bottom (wobbly)
    for (int i = 0; i <= segments; i++) {
      final x = i * segmentWidth;
      final wobble = (random.nextDouble() - 0.5) * 3;
      final y = height + wobble;
      
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    // Right side (wobbly)
    for (int i = 1; i <= 8; i++) {
      final y = height - (i / 8) * height;
      final wobble = (random.nextDouble() - 0.5) * 3;
      final x = width + wobble;
      path.lineTo(x, y);
    }

    // Top (wobbly)
    for (int i = segments; i >= 0; i--) {
      final x = i * segmentWidth;
      final wobble = (random.nextDouble() - 0.5) * 3;
      final y = wobble;
      path.lineTo(x, y);
    }

    // Left side (wobbly)
    for (int i = 1; i < 8; i++) {
      final y = (i / 8) * height;
      final wobble = (random.nextDouble() - 0.5) * 3;
      final x = wobble;
      path.lineTo(x, y);
    }

    path.close();

    // Fill
    final fillPaint = Paint()
      ..color = color.withOpacity(0.7)
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);

    // Border
    final borderPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, borderPaint);

    // Add scribble texture inside
    for (int i = 0; i < 15; i++) {
      if (random.nextDouble() > 0.5) {
        final x = random.nextDouble() * width;
        final y = random.nextDouble() * height;
        final scribblePaint = Paint()
          ..color = color.withOpacity(0.3)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5;
        
        canvas.drawLine(
          Offset(x, y),
          Offset(x + (random.nextDouble() - 0.5) * 8, y + (random.nextDouble() - 0.5) * 8),
          scribblePaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_ScribbledBarPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.value != value;
}

