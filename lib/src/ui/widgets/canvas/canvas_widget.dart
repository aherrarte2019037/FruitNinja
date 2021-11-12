import 'dart:math';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fruit_ninja/src/models/fruit_model.dart';
import 'package:fruit_ninja/src/models/fruit_part_model.dart';
import 'package:fruit_ninja/src/ui/widgets/canvas/canvas_widget_controller.dart';
import 'package:fruit_ninja/src/ui/widgets/slice_painter_widget.dart';

class CanvasWidget extends StatefulWidget {
  const CanvasWidget({ Key? key }) : super(key: key);

  @override
  _CanvasWidgetState createState() => _CanvasWidgetState();
}

class _CanvasWidgetState extends State<CanvasWidget> with WidgetsBindingObserver {
  final CanvasWidgetController _controller = CanvasWidgetController();

  updateView() => setState(() {});

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _controller.init(context, updateView);
    });
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) _controller.handleSoundButton(mute: true);
    if (state == AppLifecycleState.resumed) _controller.handleSoundButton(mute: false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _gestureSlice(),
        _backButton(),
        _soundButton(),
        _score(),
        for (FruitPart fruitPart in _controller.fruitParts) _fruitSliceWidget(fruitPart),
        for (Fruit fruit in _controller.fruits) _fruitWidget(fruit),
        _gestureDetector(),
      ],
    );
  }

  Widget _gestureSlice() {
    return CustomPaint(
      size: Size.infinite,
      painter: SlicePainter(pointsList: _controller.touchSlice.pointsList),
    );
  } 

  Widget _gestureDetector() {
    return GestureDetector(
      onScaleStart: (details) => _controller.setNewSlice(details),
      onScaleUpdate: (details) => _controller.addPointToSlice(details),
      onScaleEnd: (details) => _controller.resetSlice(),
    );
  }

  Widget _fruitWidget(Fruit fruit){
    return Positioned(
      left: fruit.position.dx,
      top: fruit.position.dy,
      child: Transform.rotate(
        angle: fruit.rotation * pi * 2,
        child: Image.asset(
          _controller.fruitImages[_controller.currentRandom],
          height: 80,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }

  Widget _fruitSliceWidget(FruitPart fruitPart){
    return Positioned(
      left: fruitPart.position.dx,
      top: fruitPart.position.dy,
      child: Transform.rotate(
      angle: fruitPart.rotation * pi * 2,
        child: Image.asset(
          fruitPart.isLeft
            ? _controller.leftFruitImageParts[_controller.currentRandom]
            : _controller.rightFruitImageParts[_controller.currentRandom],
          height: 80,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }

  Widget _score() {
    return Positioned(
      right: 30,
      top: 30,
      width: 120,
      height: 50,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          image: const DecorationImage(
            fit: BoxFit.contain,
            image: AssetImage('assets/images/score-background.png'),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: ZoomIn(
              from: 1,
              manualTrigger: true,
              duration: const Duration(milliseconds: 300),
              controller: (controller) => _controller.scoreController = controller,
              child: Text(
                _controller.score.toString(),
                style: const TextStyle(
                  color: Color(0XFF3A2922),
                  fontSize: 18,
                  fontFamily: '8BIT WONDER',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _soundButton() {
    return Positioned(
      right: 165,
      top: 32,
      width: 49,
      height: 49,
      child: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            fit: BoxFit.contain,
            image: AssetImage('assets/images/button-square-background.png'),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: ElevatedButton(
            onPressed: _controller.handleSoundButton,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: const EdgeInsets.all(10),
              primary: Colors.transparent,
              onPrimary: const Color(0XFF3A2922),
              fixedSize: const Size(49, 49),
              minimumSize: const Size(49, 49),
            ),
            child: Image.asset(
              _controller.isMuted ? 'assets/images/mute-icon.png' : 'assets/images/unmute-icon.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

  Widget _backButton() {
    return Positioned(
      left: 40,
      top: 32,
      width: 49,
      height: 49,
      child: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            fit: BoxFit.contain,
            image: AssetImage('assets/images/button-square-background.png'),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: ElevatedButton(
            onPressed: _controller.goBack,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.only(top: 12, bottom: 12, right: 3),
              elevation: 0,
              primary: Colors.transparent,
              onPrimary: const Color(0XFF3A2922),
              fixedSize: const Size(49, 49),
              minimumSize: const Size(49, 49),
            ),
            child: Image.asset(
              'assets/images/arrow-back-icon.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

}