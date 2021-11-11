import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fruit_ninja/src/models/fruit_model.dart';
import 'package:fruit_ninja/src/models/fruit_part_model.dart';
import 'package:fruit_ninja/src/models/touch_slice_model.dart';

class CanvasWidgetController {
  late BuildContext context;
  late Function updateView;
  Size screenSize = const Size(0, 0);
  int currentRandom = 0;
  int score = 0;
  List<Fruit> fruits = [];
  List<FruitPart> fruitParts = [];
  List<String> leftFruitImageParts = [
    'assets/images/fruits/apple-cut-left.png',
    'assets/images/fruits/orange-cut-left.png',
    'assets/images/fruits/cherry-cut-left.png',
    'assets/images/fruits/watermelon-cut-left.png',
    'assets/images/fruits/melon-cut-left.png',
  ];
  List<String> rightFruitImageParts = [
    'assets/images/fruits/apple-cut-right.png',
    'assets/images/fruits/orange-cut-right.png',
    'assets/images/fruits/cherry-cut-left.png',
    'assets/images/fruits/watermelon-cut-right.png',
    'assets/images/fruits/melon-cut-left.png',
  ];
  List<String> fruitImages = [
    'assets/images/fruits/apple.png',
    'assets/images/fruits/orange.png',
    'assets/images/fruits/cherry.png',
    'assets/images/fruits/watermelon.png',
    'assets/images/fruits/melon.png',
  ];
  TouchSlice touchSlice = TouchSlice(pointsList: []);
  
  void init(BuildContext context, Function updateView) {
    this.context = context;
    this.updateView = updateView;
    setScreenSize();
    updateGravity();
    Timer.periodic(const Duration(seconds: 2), addRandomFruit);
    updateView();
  }

  void updateGravity() {
    for (Fruit fruit in fruits) {
      fruit.applyGravity();
    }

    for (FruitPart fruitPart in fruitParts) {
      fruitPart.applyGravity();
    }

    Future.delayed(const Duration(milliseconds: 30), updateGravity);
    updateView();
  }

  void setScreenSize() {
    screenSize = Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
  }

  void addRandomFruit(Timer timer) {
    fruits.add(
      Fruit(
        position: Offset(
          Random().nextInt(screenSize.width.toInt() - 180).toDouble(),
          screenSize.height,
        ),
        width: 80,
        height: 80,
        additionalForce: Offset(
          5 + Random().nextDouble() * 5,
          (Random().nextInt(14) + 18) * -1,
        ),
        rotation: Random().nextDouble() / 3 - 0.16,
      ),
    );
    currentRandom = Random().nextInt(fruitImages.length - 1);
  }

  void setNewSlice(ScaleStartDetails details) {
    touchSlice = TouchSlice(pointsList: [details.localFocalPoint]);
    updateView();
  }

  void addPointToSlice(ScaleUpdateDetails details) {
    if (touchSlice.pointsList.length > 14) touchSlice.pointsList.removeAt(0);
    touchSlice.pointsList.add(details.localFocalPoint);

    checkSliceInside();
  }

  void resetSlice() {
    touchSlice = TouchSlice(pointsList: []);
  }

  void checkSliceInside() {
    for (Fruit fruit in List.from(fruits)) {
      bool firstPointOutside = false;
      bool secondPointInside = false;

      for (Offset point in touchSlice.pointsList) {
        if (!firstPointOutside && !fruit.isPointInside(point)) {
          firstPointOutside = true;
          continue;
        }

        if (firstPointOutside && fruit.isPointInside(point)) {
          secondPointInside = true;
          continue;
        }

        if (secondPointInside && !fruit.isPointInside(point)) {
          turnFruitIntoSlice(fruit);
          break;
        }
      }
    }
    
    updateView();
  }

  void turnFruitIntoSlice(Fruit fruitSliced) {
    FruitPart leftSlice = FruitPart(
        position: Offset(
          fruitSliced.position.dx - fruitSliced.width / 8,
          fruitSliced.position.dy
        ),
        width: fruitSliced.width / 2,
        height: fruitSliced.height,
        isLeft: true,
        additionalForce: Offset(fruitSliced.additionalForce.dx - 1, 0),
        rotation: fruitSliced.rotation,
    );
    FruitPart rightSlice = FruitPart(
        position: Offset(
          fruitSliced.position.dx + fruitSliced.width / 4 + fruitSliced.width / 8,
          fruitSliced.position.dy
        ),
        width: fruitSliced.width / 2,
        height: fruitSliced.height,
        isLeft: false,
        additionalForce: Offset(fruitSliced.additionalForce.dx + 1, 0),
        rotation: fruitSliced.rotation,
    );

    score += 20;
    fruitParts.addAll([leftSlice, rightSlice]);
    fruits.remove(fruitSliced);
    updateView();
  }

}