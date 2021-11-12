import 'package:flutter/material.dart';

abstract class GravitationalObject {
  final double _gravity = 1.0;
  Offset position;
  double gravitySpeed;
  Offset additionalForce;
  double rotation;
  
  GravitationalObject({
    required this.rotation,
    required this.position,
    this.gravitySpeed = 0.0,
    this.additionalForce = const Offset(0, 0)
  });

  void applyGravity() {
    gravitySpeed += _gravity;
    position = Offset(
      position.dx + additionalForce.dx,
      position.dy + gravitySpeed + additionalForce.dy
    );
  }

}