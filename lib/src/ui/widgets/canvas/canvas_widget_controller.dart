import 'package:flutter/material.dart';
import 'package:fruit_ninja/src/models/touch_slice_model.dart';

class CanvasWidgetController {
  late BuildContext context;
  late Function updateView;
  TouchSlice touchSlice = TouchSlice(pointsList: []);
  
  void init(BuildContext context, Function updateView) {
    this.context = context;
    this.updateView = updateView;
  }

  void setNewSlice(ScaleStartDetails details) {
    touchSlice = TouchSlice(pointsList: [details.localFocalPoint]);
    updateView();
  }

  void addPointToSlice(ScaleUpdateDetails details) {
    if (touchSlice.pointsList.length > 14) touchSlice.pointsList.removeAt(0);
    touchSlice.pointsList.add(details.localFocalPoint);
  }

  void resetSlice() {
    touchSlice = TouchSlice(pointsList: []);
  }

}