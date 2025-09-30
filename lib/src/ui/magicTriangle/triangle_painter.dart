import 'package:flutter/material.dart';

class TrianglePainter extends CustomPainter {
  final Color color;
  final double radius;
  final double padding;
  final double strokeWidth;

  const TrianglePainter({
    required this.color,
    this.radius = 0,
    this.padding = 0,
    this.strokeWidth = 2.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = color
      ..strokeWidth = strokeWidth
      ..isAntiAlias = true; // ✅ smoother edges

    final path = Path()
      ..moveTo(size.width / 2, radius + padding) // top
      ..lineTo(radius + padding, size.height - radius - padding) // bottom left
      ..lineTo(size.width - radius - padding, size.height - radius - padding) // bottom right
      ..close(); // close the triangle

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant TrianglePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.radius != radius ||
        oldDelegate.padding != padding ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}