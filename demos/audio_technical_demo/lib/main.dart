import 'package:flutter/material.dart';
import 'package:flutter_soloud/flutter_soloud.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  //Define all necessary SoLoud components so we can use their states anywhere.
  final SoLoud soLoud = SoLoud.instance;
  late SoundHandle _handle;
  late AudioSource _source;

  //Set default playing position & turn off player by default.
  late bool isLeft = true;
  late bool isPlaying = false;

  //Define starting 3D sound coordinates.
  late double soundX = 0.0;
  late double soundY = 0.0;
  late double soundZ = 0.0;

  //Define the transition duration for effects.
  late Duration transitionEffectRate = Durations.extralong1;

  //Define all the strings so we don't have to dig through code for them.
  final String startText = "Start";
  final String stopText = "Stop";
  final String switchText = "Switch L/R effect";
  final String effectText = "Add effect";
  final String rockText = "Play 'rock'";
  final String funkText = "Play 'funk'";
  final String rockTestPath = 'assets/testaudio2.mp3';
  final String funkTestPath = 'assets/testaudio.mp3';

  //Stop play and release all associated resources.
  @override
  void dispose() {
    soLoud.stop(_handle);
    soLoud.disposeAllSources();
    soLoud.deinit();
  }

  //Load and play the (selected-) local asset.
  void playAudio(String testPath) async {
    setState(() {
      isPlaying = true;
    });

    await soLoud.init();
    _source = await soLoud.loadAsset(testPath);
    _handle = await soLoud.play3d(_source, 0, 0, 0);
  }

  //Stop and dispose the player & associated resources.
  Future<void> stopAndDisposeAudio() async {
    await soLoud.stop(_handle);
    await soLoud.disposeSource(_source);

    setState(() {
      isPlaying = false;
    });
  }

  //Switch L to R using a transition.
  Future<void> switchEars() async {
    if (isLeft) {
      //1.0 is panned to right by default. https://pub.dev/documentation/flutter_soloud/latest/flutter_soloud/SoLoud/play.html
      soLoud.fadePan(_handle, 1.0, transitionEffectRate);
    } else {
      //-1.0 is panned to left by default. https://pub.dev/documentation/flutter_soloud/latest/flutter_soloud/SoLoud/play.htmls
      soLoud.fadePan(_handle, -1.0, transitionEffectRate);
    }

    setState(() {
      isLeft = !isLeft;
    });
  }

  //Set the current position of the audio within the 3D space.
  void setSoundPosition(
      {double xCord = 0, double yCord = 0, double zCord = 0}) {
    setState(() {
      soundX = xCord;
      soundY = yCord;
      soundZ = zCord;
    });

    soLoud.set3dSourcePosition(_handle, soundX, soundY, soundZ);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: !isPlaying ? () => playAudio(rockTestPath) : null,
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all<Color?>(Colors.greenAccent),
                ),
                child: Text(
                  rockText,
                ),
              ),
              ElevatedButton(
                onPressed: !isPlaying ? () => playAudio(funkTestPath) : null,
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all<Color?>(Colors.greenAccent),
                ),
                child: Text(
                  funkText,
                ),
              ),
              ElevatedButton(
                onPressed: isPlaying ? stopAndDisposeAudio : null,
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all<Color?>(Colors.redAccent),
                ),
                child: Text(
                  stopText,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                onPressed: isPlaying ? switchEars : null,
                child: Text(switchText),
              ),
              const SizedBox(
                height: 32,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: isPlaying
                              ? () => setSoundPosition(zCord: 250)
                              : null,
                          icon: const Icon(Icons.arrow_circle_up),
                          iconSize: 48,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: isPlaying
                              ? () => setSoundPosition(xCord: -250)
                              : null,
                          icon: const Icon(Icons.arrow_circle_left),
                          iconSize: 48,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        IconButton(
                          onPressed: isPlaying
                              ? () => setSoundPosition(xCord: 250)
                              : null,
                          icon: const Icon(Icons.arrow_circle_right),
                          iconSize: 48,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: isPlaying
                              ? () => setSoundPosition(zCord: -250)
                              : null,
                          icon: const Icon(Icons.arrow_circle_down),
                          iconSize: 48,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
