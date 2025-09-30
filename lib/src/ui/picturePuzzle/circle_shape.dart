import 'package:flutter/material.dart';

class CircleShape extends CustomPainter {
  final Color color;
  final double strokeWidth;

  const CircleShape({
    required this.color,
    this.strokeWidth = 2.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.shortestSide / 2; // ensures circle fits in both directions

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = color
      ..strokeWidth = strokeWidth
      ..isAntiAlias = true;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2), // center
      radius - strokeWidth / 2, // ensures stroke stays inside
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CircleShape oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}