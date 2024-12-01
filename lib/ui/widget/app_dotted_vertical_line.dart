import 'package:flutter/material.dart';

class AppDottedVerticalLine extends StatelessWidget {
  final double height;
  final Color color;
  final double strokeWidth;
  final double gapSize;

  const AppDottedVerticalLine({
    super.key,
    this.height = 100,
    this.color = Colors.black,
    this.strokeWidth = 1,
    this.gapSize = 4,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DottedLinePainter(
        color: color,
        strokeWidth: strokeWidth,
        gapSize: gapSize,
      ),
      child: Container(
        height: height,
      ),
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gapSize;

  _DottedLinePainter({
    required this.color,
    required this.strokeWidth,
    required this.gapSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final double dashWidth = gapSize;
    final double dashSpace = gapSize;

    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, startY + dashWidth),
        paint,
      );
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
