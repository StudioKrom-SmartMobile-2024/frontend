import 'dart:math';
import 'package:flutter_soloud/flutter_soloud.dart';

abstract class SoundManager {
  late int currentPosition = 0;
  late double soundCertainty = 1.0;
  late List<SoundHandle> handles = [];
  late List<AudioSource> usedSources = [];
  final soloud = SoLoud.instance;

  SoundManager(this.currentPosition, {this.soundCertainty = 1.0});

  void stopAndClean() {
    for (SoundHandle handle in handles) {
      soloud.stop(handle);
    }
    soloud.disposeAllSources();
    usedSources = List.empty();
  }

  void pauseAll() {
    for (SoundHandle handle in handles) {
      soloud.setPause(handle, true);
    }
  }

  void resumeAll() {
    for (SoundHandle handle in handles) {
      soloud.setPause(handle, false);
    }
  }

  Future<void> playSound(String pathToSound,
      {double posX = 0,
      double posY = 0,
      double posZ = 0,
      double vol = 0.5,
      bool loop = false}) async {
    final source = await soloud.loadAsset(pathToSound);

    if (usedSources.contains(source)) {
      return;
    }

    usedSources.add(source);

    final handle = await soloud.play3d(source, posX, posY, posZ,
        volume: vol, looping: loop);
    handles.add(handle);
  }

  bool shouldPlaySound(double soundCertainty) {
    final random = Random();
    return random.nextDouble() <= soundCertainty;
  }

  void updatePosition(int position) {
    this.currentPosition = position;
  }

  void checkStopwatchForSounds();
}

class TrainStationSceMan extends SoundManager {
  TrainStationSceMan(super.currentPosition, {super.soundCertainty}) {
    soloud.init();
  }

  static const basePath = "assets/audio/train";
  String nsAnnouncementPath = '$basePath/ns.mp3';
  String kidScreamingPath = '$basePath/kid-screams.mp3';
  String doorSlamPath = '$basePath/door-slam.mp3';
  String escalatorAmbiencePath = '$basePath/escalator-ambience.mp3';
  String genericCrowdPath = '$basePath/generic-crowd.mp3';
  String trainArrivingPath = '$basePath/train-arriving.mp3';
  String trainPassingPath = '$basePath/train-passing.mp3';
  String virmCloseDoorPath = '$basePath/VIRM-door-close.mp3';
  String dogBarkPath = '$basePath/dog-barking';

  @override
  void checkStopwatchForSounds() {
    if (!shouldPlaySound(soundCertainty)) return;

    switch (currentPosition) {
      case > 0 && < 250:
        playSound(escalatorAmbiencePath, posZ: -10, vol: 1.0, loop: true);
      case > 1000 && < 1200:
        playSound(doorSlamPath, posX: 50, vol: 0.7);
      case > 2000 && < 2200:
        playSound(nsAnnouncementPath, posY: 10, vol: 0.8);
      case > 5500 && < 5700:
        playSound(kidScreamingPath, posZ: -50, posX: -25, vol: 0.3);
      case > 7000 && < 7200:
        playSound(trainPassingPath, posX: 25, vol: 2.0);
    }
  }
}

class ConcertSceMan extends SoundManager {
  ConcertSceMan(super.currentPosition, {super.soundCertainty}) {
    soloud.init();
  }

  static const basePath = "assets/audio/concert";
  String examplePath = '$basePath/idontexist.mp3';

  @override
  void checkStopwatchForSounds() {
    if (!shouldPlaySound(soundCertainty)) return;

    switch (currentPosition) {
      case > 0 && < 250:
        playSound(examplePath);
    }
  }
}

class MallSceMan extends SoundManager {
  MallSceMan(super.currentPosition, {super.soundCertainty}) {
    soloud.init();
  }

  static const basePath = "assets/audio/mall";
  String examplePath = '$basePath/idontexist.mp3';

  @override
  void checkStopwatchForSounds() {
    if (!shouldPlaySound(soundCertainty)) return;

    switch (currentPosition) {
      case > 0 && < 250:
        playSound(examplePath);
    }
  }
}

class EmptySoundManager extends SoundManager {
  EmptySoundManager(super.currentPosition, {super.soundCertainty}) {
    soloud.init();
  }

  @override
  Future<void> checkStopwatchForSounds() async {
    print("Unimplemented method found!");
  }
}
