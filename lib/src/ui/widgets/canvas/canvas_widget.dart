import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fruit_ninja/src/models/fruit_model.dart';
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
        _gestureDetector(),
        for (Fruit fruit in _controller.fruits) _fruitWidget(fruit),

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
      child: _appleImageWidget(),
    );
  }

  Widget _appleImageWidget() {
    return Image.asset(
      'assets/images/apple-png',
      height: 80,
      fit: BoxFit.fitHeight,
    );
  }

}