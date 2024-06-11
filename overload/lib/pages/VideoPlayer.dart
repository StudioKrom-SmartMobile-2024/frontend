import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:overload/models/experience_params.dart';
import 'package:overload/models/experience_type.dart';
import 'package:overload/utils/SoundManager.dart';
import 'package:overload/widgets/vr-overlays/confirmation_dialogue.dart';
import 'package:overload/widgets/vr-overlays/settings_overlay.dart';
import 'package:vr_player/vr_player.dart';
import 'package:flutter/material.dart';

class VideoPlayerPage extends StatefulWidget {
  final ExperienceParams params;
  late final SoundManager soundMan;

  VideoPlayerPage({
    Key? key,
    required this.params,
  }) : super(key: key) {
    switch (this.params.type) {
      case ExperienceType.trainStation:
        soundMan = TrainStationSceMan(0, soundCertainty: 1.0);
        break;
      default:
        soundMan = EmptySoundManager(0, soundCertainty: 0.0);
    }
  }

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
            ConfirmationDialogue(
              onConfirm: confirmLeave,
              onCancel: cancelLeave,
              popupDescription: 'Are you sure you want to exit the experience?',
              confirmText: 'Exit',
              cancelText: 'Stay',
              popupTitle: 'EXIT EXPERIENCE',
            ),
          if (_isDisclaimerShowing)
            ConfirmationDialogue(
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
    widget.soundMan.stopAndClean();
    setState(() {
      _isShowingConfirmExit = false;
    });

    context.go("/home");
  }

  void cardBoardPressed() {
    _viewPlayerController.toggleVRMode();
    setState(() {
      _isVideoVR = !_isVideoVR;
    });
  }

  Future<void> exitExperience() async {
    await _viewPlayerController.pause();
    widget.soundMan.pauseAll();
    setState(() {
      _isShowingConfirmExit = true;
    });
  }

  Future<void> pauseOrPlayVR({required bool pause}) async {
    if (pause) {
      await _viewPlayerController.pause();
      widget.soundMan.pauseAll();
    } else {
      await _viewPlayerController.play();
      widget.soundMan.resumeAll();
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
      videoUrl: widget.params.url,
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
    widget.soundMan.updatePosition(millis);
  }

  void onChangePosition(int millis) {
    widget.soundMan.updatePosition(millis);
    widget.soundMan.checkStopwatchForSounds();
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
