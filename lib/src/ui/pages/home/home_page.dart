import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fruit_ninja/src/ui/pages/home/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final HomeController _controller = HomeController();
  
  void updateView() => setState(() {});

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
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/scene-1.gif')
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 40, top: 20),
                child: Align(
                  alignment: Alignment.topRight,
                  child: _soundButton(),
                ),
              ),
              const Spacer(),
              Transform.translate(
                offset: const Offset(0, 0),
                child: Align(
                  alignment: Alignment.center,
                  child: _titleText(),
                ),
              ),
              const SizedBox(height: 35),
              _selectScene(),
              const Spacer(),
              _creatorName(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _soundButton() {
    return Container(
      width: 50,
      height: 50,
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
          ),
          child: Image.asset(
            _controller.isMuted ? 'assets/images/mute-icon.png' : 'assets/images/unmute-icon.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _titleText() {
    return const Text(
      'Flutter Ninja',
      style: TextStyle(
        color: Colors.white,
        fontSize: 48,
        fontFamily: '8BIT WONDER',
      ),
    );
  }

  Widget _selectScene() {
    return Transform.translate(
      offset: const Offset(0, 0),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: 190,
          decoration: BoxDecoration(
            image: const DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage('assets/images/score-background.png'),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Center(
            child: ElevatedButton(
              onPressed: _controller.showSceneSelectDialog,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: Colors.transparent,
                onPrimary: const Color(0XFF3A2922),
                fixedSize: const Size(300, 80),
                minimumSize: const Size(300, 80),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: ZoomIn(
                    from: 1,
                    duration: const Duration(milliseconds: 300),
                    child: const Text(
                      'Jugar',
                      style: TextStyle(
                        color: Color(0XFF3A2922),
                        fontSize: 20,
                        fontFamily: '8BIT WONDER',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _creatorName() {
    return Padding(
      padding: const EdgeInsets.only(right: 40, bottom: 20),
      child: Align(
        alignment: Alignment.bottomRight,
        child: const Text(
          '@ Angel Herrarte',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontFamily: '8BIT WONDER',
          ),
        ),
      ),
    );

  }

}