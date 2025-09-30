import 'package:flutter/material.dart';

class SquareShape extends CustomPainter {
  final Color color;
  final double stroke;

  SquareShape(this.color, this.stroke);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = color
      ..strokeWidth = stroke
      ..strokeJoin = StrokeJoin.round;

    final path = Path()
      ..moveTo(0, 0) // start at top-left
      ..lineTo(size.width, 0) // top-right
      ..lineTo(size.width, size.height) // bottom-right
      ..lineTo(0, size.height) // bottom-left
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant SquareShape oldDelegate) {
    return oldDelegate.color != color || oldDelegate.stroke != stroke;
  }
}