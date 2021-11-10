import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fruit_ninja/src/ui/pages/game/game_controller.dart';
import 'package:fruit_ninja/src/ui/widgets/canvas/canvas_widget.dart';

class GamePage extends StatefulWidget {
  const GamePage({ Key? key }) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final GameController _controller = GameController();

  updateView() => setState(() {});

  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _controller.init(context, updateView);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/scene-1.gif')
            )
          ),
          child: const CanvasWidget(),
        ),
      ),
    );
  }

}