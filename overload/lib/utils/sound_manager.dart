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
      {double posX = 0, double posY = 0, double posZ = 0}) async {
    final source = await soloud.loadAsset(pathToSound);

    if (usedSources.contains(source)) {
      return;
    }

    usedSources.add(source);

    final handle = await soloud.play3d(source, posX, posY, posZ);
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

  String nsAnnouncementPath = 'assets/audio/ns.mp3';

  @override
  void checkStopwatchForSounds() {
    if (!shouldPlaySound(soundCertainty)) return;

    switch (currentPosition) {
      case > 1400 && < 1500:
        playSound(nsAnnouncementPath, posY: 50);
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
