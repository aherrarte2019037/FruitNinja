import 'package:flutter/material.dart';

class GameController {
  late BuildContext context;
  late Function updateView;
  
  void init(BuildContext context, Function updateView) {
    this.context = context;
    this.updateView = updateView;
  }

}