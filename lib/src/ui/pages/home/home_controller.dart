import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class HomeController {
  late BuildContext context;
  late Function updateView;
  AudioPlayer backgroundPlayer = AudioPlayer();
  bool isMuted = false;
  
  void init(BuildContext context, Function updateView) {
    this.context = context;
    this.updateView = updateView;
    backgroundPlayer.setAsset('assets/audio/track-2.mp3');
    playBackgroundAudio();
  }

  void goToGame(String backgroundAsset) {
    backgroundPlayer.dispose();
    Navigator.popAndPushNamed(context, 'game', arguments: backgroundAsset);
  }
  
  Future<void> playBackgroundAudio() async {
    await backgroundPlayer.setVolume(0.4);
    await backgroundPlayer.setLoopMode(LoopMode.one);
    backgroundPlayer.play();
  }

  void handleSoundButton({bool? mute}) {
    if (!isMuted || (mute != null && mute)) {
      backgroundPlayer.pause();

    } else {
      playBackgroundAudio();
    }

    isMuted = !isMuted;
    updateView();
  }

  void showSceneSelectDialog() {
    showDialog(context: context, builder: (_) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: FractionallySizedBox(
          widthFactor: 0.6,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/scene-select-background.png'),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: const Color(0XFF3A2922), width: 3),
                            ),
                            child: Image.asset(
                              'assets/images/scene-1.gif',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 38,
                            child: Container(
                              width: 35,
                              height: 35,
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
                                ]
                              ),
                              child: ElevatedButton(
                                onPressed: () => goToGame('assets/images/scene-1.gif'),
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  padding: const EdgeInsets.only(top: 9, bottom: 9, left: 3, right: 2),
                                  primary: Colors.transparent,
                                  onPrimary: const Color(0XFF3A2922),
                                ),
                                child: Image.asset(
                                  'assets/images/play-icon.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: const Color(0XFF3A2922), width: 3),
                            ),
                            child: Image.asset(
                              'assets/images/scene-2.gif',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 20,
                            child: Container(
                              width: 35,
                              height: 35,
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
                                ]
                              ),
                              child: ElevatedButton(
                                onPressed: () => goToGame('assets/images/scene-2.gif'),
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  padding: const EdgeInsets.only(top: 9, bottom: 9, left: 3, right: 2),
                                  primary: Colors.transparent,
                                  onPrimary: const Color(0XFF3A2922),
                                ),
                                child: Image.asset(
                                  'assets/images/play-icon.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: const Color(0XFF3A2922), width: 3),
                            ),
                            child: Image.asset(
                              'assets/images/scene-3.gif',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 20,
                            child: Container(
                              width: 35,
                              height: 35,
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
                                ]
                              ),
                              child: ElevatedButton(
                                onPressed: () => goToGame('assets/images/scene-3.gif'),
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  padding: const EdgeInsets.only(top: 9, bottom: 9, left: 3, right: 2),
                                  primary: Colors.transparent,
                                  onPrimary: const Color(0XFF3A2922),
                                ),
                                child: Image.asset(
                                  'assets/images/play-icon.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 75),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: const Color(0XFF3A2922), width: 3),
                            ),
                            child: Image.asset(
                              'assets/images/scene-4.gif',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 20,
                            child: Container(
                              width: 35,
                              height: 35,
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
                                ]
                              ),
                              child: ElevatedButton(
                                onPressed: () => goToGame('assets/images/scene-4.gif'),
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  padding: const EdgeInsets.only(top: 9, bottom: 9, left: 3, right: 2),
                                  primary: Colors.transparent,
                                  onPrimary: const Color(0XFF3A2922),
                                ),
                                child: Image.asset(
                                  'assets/images/play-icon.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: const Color(0XFF3A2922), width: 3),
                            ),
                            child: Image.asset(
                              'assets/images/scene-5.gif',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 24,
                            child: Container(
                              width: 35,
                              height: 35,
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
                                    offset: const Offset(0, 0),
                                  ),
                                ]
                              ),
                              child: ElevatedButton(
                                onPressed: () => goToGame('assets/images/scene-5.gif'),
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  padding: const EdgeInsets.only(top: 9, bottom: 9, left: 3, right: 2),
                                  primary: Colors.transparent,
                                  onPrimary: const Color(0XFF3A2922),
                                ),
                                child: Image.asset(
                                  'assets/images/play-icon.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: const Color(0XFF3A2922), width: 3),
                            ),
                            child: Image.asset(
                              'assets/images/scene-6.gif',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 18,
                            child: Container(
                              width: 35,
                              height: 35,
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
                                ]
                              ),
                              child: ElevatedButton(
                                onPressed: () => goToGame('assets/images/scene-6.gif'),
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  padding: const EdgeInsets.only(top: 9, bottom: 9, left: 3, right: 2),
                                  primary: Colors.transparent,
                                  onPrimary: const Color(0XFF3A2922),
                                ),
                                child: Image.asset(
                                  'assets/images/play-icon.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

}