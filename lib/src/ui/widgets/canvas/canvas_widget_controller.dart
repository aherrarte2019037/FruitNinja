import 'package:flutter/material.dart';
import 'package:fruit_ninja/src/models/fruit_model.dart';
import 'package:fruit_ninja/src/models/touch_slice_model.dart';

class CanvasWidgetController {
  late BuildContext context;
  late Function updateView;
  List<Fruit> fruits = [];
  TouchSlice touchSlice = TouchSlice(pointsList: []);
  
  void init(BuildContext context, Function updateView) {
    this.context = context;
    this.updateView = updateView;
    fruits = generateFruits();
    updateView();
  }

  List<Fruit> generateFruits() {
    List<Fruit> fruits = [
      Fruit(position: const Offset(100, 100), width: 80, height: 80),
      Fruit(position: const Offset(400, 100), width: 80, height: 80),
      Fruit(position: const Offset(600, 100), width: 80, height: 80),
    ];

    return fruits;
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
          fruits.remove(fruit);
          break;
        }
      }
    }
    
    updateView();
  }

}