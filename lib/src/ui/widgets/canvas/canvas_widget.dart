import 'dart:math';
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

class _CanvasWidgetState extends State<CanvasWidget> {
  final CanvasWidgetController _controller = CanvasWidgetController();

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
    return Stack(
      children: [
        _gestureSlice(),
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
      right: 50,
      top: 30,
      width: 150,
      height: 40,
      child: Container(
        color: Colors.white,
        child: Text(
          _controller.score.toString(),
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

}