
import 'package:flutter/material.dart';
import 'package:fruit_ninja/src/models/gravitatonial_object_model.dart';

class FruitPart extends GravitationalObject {
  double width;
  double height;
  bool isLeft;

  FruitPart({
    position,
    rotation = 0.0,
    gravitySpeed = 0.0,
    additionalForce = const Offset(0, 0),
    required this.width,
    required this.height,
    required this.isLeft
  }) : super(position: position, gravitySpeed: gravitySpeed, additionalForce: additionalForce, rotation: rotation);

}