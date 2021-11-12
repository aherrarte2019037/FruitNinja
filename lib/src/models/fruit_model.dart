import 'package:flutter/material.dart';
import 'package:fruit_ninja/src/models/gravitatonial_object_model.dart';

class Fruit extends GravitationalObject {
  double width;
  double height;

  Fruit({
    position,
    rotation = 0.0,
    gravitySpeed = 0.0,
    additionalForce = const Offset(0, 0),
    required this.width,
    required this.height,
  }) : super(position: position, gravitySpeed: gravitySpeed, additionalForce: additionalForce, rotation: rotation);

  bool isPointInside(Offset point) {
    if (point.dx < position.dx) {
      return false;
    }

    if (point.dx > position.dx + width) {
      return false;
    }

    if (point.dy < position.dy) {
      return false;
    }

    if (point.dy > position.dy + height) {
      return false;
    }

    return true;
  }

}