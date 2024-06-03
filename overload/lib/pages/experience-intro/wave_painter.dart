import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {
  final Color waveColor;

  WavePainter({required this.waveColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = waveColor
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height * 0.9)
      ..cubicTo(
        size.width * 0.25,
        size.height * 0.05,
        size.width * 0.75,
        size.height * 1.5,
        size.width,
        size.height * 0.8,
      )
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is WavePainter && oldDelegate.waveColor != waveColor;
  }
}
