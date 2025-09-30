import 'package:flutter/material.dart';

class TriangleShape extends CustomPainter {
  final Color color;
  final double stroke;

  TriangleShape(this.color, this.stroke);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = color
      ..strokeWidth = stroke
      ..strokeJoin = StrokeJoin.round;

    final path = Path()
      ..moveTo(size.width / 2, 0)          // Top center
      ..lineTo(0, size.height)             // Bottom left
      ..lineTo(size.width, size.height)    // Bottom right
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant TriangleShape oldDelegate) {
    return oldDelegate.color != color || oldDelegate.stroke != stroke;
  }
}