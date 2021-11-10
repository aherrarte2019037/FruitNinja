import 'package:flutter/material.dart';

class SlicePainter extends CustomPainter {
  List<Offset> pointsList = [];
  Paint paintObject = Paint();

  SlicePainter({required this.pointsList});

  @override
  void paint(Canvas canvas, Size size) => _drawPath(canvas);

  void _drawPath(Canvas canvas) {
    Path path = Path();
    paintObject.color = Colors.white;
    paintObject.strokeWidth = 3;
    paintObject.style = PaintingStyle.fill;

    if (pointsList.length < 3) return;

    paintObject.style = PaintingStyle.stroke;
    path.moveTo(pointsList[0].dx, pointsList[0].dy);

    for (int i = 1; i < pointsList.length - 1; i++) {
      path.lineTo(pointsList[i].dx, pointsList[i].dy);
    }

    canvas.drawPath(path, paintObject);
  }

  @override
  bool shouldRepaint(SlicePainter oldDelegate) => true;

}