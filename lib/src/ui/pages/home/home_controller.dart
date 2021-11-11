import 'package:flutter/cupertino.dart';

class HomeController {
  late BuildContext context;
  late Function updateView;
  
  void init(BuildContext context, Function updateView) {
    this.context = context;
    this.updateView = updateView;
  }

  void goToGame() => Navigator.pushNamed(context, 'game');
  
}