import 'package:flutter/material.dart';

class GameController {
  late BuildContext context;
  late Function updateView;
  String backgroundAsset = 'assets/images/scene-1.gif';
  
  void init(BuildContext context, Function updateView, String backgroundAsset) {
    this.context = context;
    this.updateView = updateView;
    this.backgroundAsset = backgroundAsset;
    updateView();
  }

}