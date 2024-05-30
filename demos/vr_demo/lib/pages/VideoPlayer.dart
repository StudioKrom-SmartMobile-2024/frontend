import 'package:flutter/services.dart';
import 'package:vr_demo/main.dart';
import 'package:vr_demo/utils/SoundManager.dart';
import 'package:vr_demo/widgets/vr-dialogues/ConfirmationDialogue.dart';
import 'package:vr_demo/widgets/vr-dialogues/SettingsOverlay.dart';
import 'package:vr_player/vr_player.dart';
import 'package:flutter/material.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({super.key});

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage>
    with TickerProviderStateMixin {
  late VrPlayerController _viewPlayerController;
  late double _playerWidth;
  late double _playerHeight;

  bool _isPlaying = false;
  bool _isSettingsShown = false;
  bool _isShowingConfirmExit = false;
  bool _isVideoVR = false;
  bool _isDisclaimerShowing = true;
  bool isVideoLoading = false;
  bool isVideoReady = false;

  TrainStationSceMan trainSceMan = TrainStationSceMan(0, soundCertainty: 1.0);

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [],
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _playerWidth = MediaQuery.of(context).size.width;
    _playerHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          VrPlayer(
            x: 0,
            y: 0,
            onCreated: onViewPlayerCreated,
            width: _playerWidth,
            height: _playerHeight,
          ),
          Positioned(
              right: 8,
              bottom: 8,
              child: IconButton(
                iconSize: 36,
                icon: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                onPressed: () => exitExperience(),
              )),
          _isSettingsShown
              ? SettingsOverlay(
                  cardBoardPressed: cardBoardPressed,
                  switchSettingsDisplay: switchSettingsDisplay,
                  isVideoVR: _isVideoVR,
                )
              : Positioned(
                  right: 8,
                  top: 8,
                  child: IconButton(
                    iconSize: 36,
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    onPressed: () => switchSettingsDisplay(true),
                  )),
          if (_isShowingConfirmExit)
            ConfirmLeaveDialogue(
              onConfirm: confirmLeave,
              onCancel: cancelLeave,
              popupDescription: 'Are you sure you want to exit the experience?',
              confirmText: 'Exit',
              cancelText: 'Stay',
              popupTitle: 'EXIT EXPERIENCE',
            ),
          if (_isDisclaimerShowing)
            ConfirmLeaveDialogue(
              onConfirm: onConfirmExperience,
              onCancel: confirmLeave,
              popupDescription:
                  'This video contains intense sensory stimuli and may not be suitable for individuals with sensory overload. Viewer discretion is advised.',
              confirmText: 'Continue',
              cancelText: 'Exit',
              popupTitle: 'DISCLAIMER',
            ),
        ],
      ),
    );
  }

  void onConfirmExperience() {
    setState(() {
      _isDisclaimerShowing = false;
    });
    pauseOrPlayVR(pause: false);
  }

  void cancelLeave() {
    setState(() {
      _isShowingConfirmExit = false;
    });
    pauseOrPlayVR(pause: false);
  }

  void confirmLeave() {
    trainSceMan.stopAndClean();
    setState(() {
      _isShowingConfirmExit = false;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  void cardBoardPressed() {
    _viewPlayerController.toggleVRMode();
    setState(() {
      _isVideoVR = !_isVideoVR;
    });
  }

  Future<void> exitExperience() async {
    await _viewPlayerController.pause();
    trainSceMan.pauseAll();
    setState(() {
      _isShowingConfirmExit = true;
    });
  }

  Future<void> pauseOrPlayVR({required bool pause}) async {
    if (pause) {
      await _viewPlayerController.pause();
      trainSceMan.pauseAll();
    } else {
      await _viewPlayerController.play();
      trainSceMan.resumeAll();
    }

    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void onViewPlayerCreated(
    VrPlayerController controller,
    VrPlayerObserver observer,
  ) {
    _viewPlayerController = controller;
    observer
      ..onStateChange = onReceiveState
      ..onDurationChange = onReceiveDuration
      ..onPositionChange = onChangePosition
      ..onFinishedChange = onReceiveEnded;
    _viewPlayerController.loadVideo(
      videoUrl: 'https://i.imgur.com/3WJFkSt.mp4',
    );
  }

  void onReceiveState(VrState state) {
    switch (state) {
      case VrState.loading:
        setState(() {
          isVideoLoading = true;
        });
        break;
      case VrState.ready:
        setState(() {
          isVideoLoading = false;
          isVideoReady = true;
        });
        break;
      case VrState.buffering:
      case VrState.idle:
        break;
    }
  }

  void onReceiveDuration(int millis) {
    trainSceMan.updatePosition(millis);
  }

  void onChangePosition(int millis) {
    trainSceMan.updatePosition(millis);
    trainSceMan.checkStopwatchForSounds();
  }

  void onReceiveEnded(bool isFinished) {
    confirmLeave();
  }

  void switchSettingsDisplay(bool show) {
    setState(() {
      _isSettingsShown = show;
    });
  }
}
