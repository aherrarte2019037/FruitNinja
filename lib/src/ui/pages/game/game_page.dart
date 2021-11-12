import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fruit_ninja/src/ui/pages/game/game_controller.dart';
import 'package:fruit_ninja/src/ui/widgets/canvas/canvas_widget.dart';

class GamePage extends StatefulWidget {
  final String backgroundAsset;

  const GamePage({ Key? key, required this.backgroundAsset }) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final GameController _controller = GameController();

  updateView() => setState(() {});

  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _controller.init(context, updateView, widget.backgroundAsset);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(_controller.backgroundAsset),
            ),
          ),
          child: const CanvasWidget(),
        ),
      ),
    );
  }

}