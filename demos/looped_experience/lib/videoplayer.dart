import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:looped_experience/models/experience_params.dart';
import 'package:looped_experience/models/experience_type.dart';
import 'package:looped_experience/utils/constants.dart';
import 'package:looped_experience/utils/sound_manager.dart';
import 'package:flutter/material.dart';
import 'package:looped_experience/vr-overlays/confirmation_dialogue.dart';
import 'package:looped_experience/vr-overlays/settings_overlay.dart';
import 'package:vr_player/vr_player.dart';

class VideoPlayerPage extends StatefulWidget {
  final ExperienceParams params;
  late final SoundManager soundMan;

  VideoPlayerPage({
    Key? key,
    required this.params,
  }) : super(key: key) {
    switch (params.type) {
      case ExperienceType.trainStation:
        soundMan = TrainStationSceMan(0, soundCertainty: params.soundCertainty);
        break;
      case ExperienceType.concert:
        soundMan = ConcertSceMan(0, soundCertainty: params.soundCertainty);
        break;
      case ExperienceType.mall:
        soundMan = MallSceMan(0, soundCertainty: params.soundCertainty);
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
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
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
                    iconSize: DEFAULT_ICON_SIZE,
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    onPressed: () => switchSettingsDisplay(true),
                  )),
          if (isVideoLoading)
            const Center(
              child: SpinKitDualRing(
                color: Colors.white,
                size: 50.0,
              ),
            ),
        ],
      ),
    );
  }

  void cardBoardPressed() {
    _viewPlayerController.toggleVRMode();
    setState(() {
      _isVideoVR = !_isVideoVR;
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
      case VrState.buffering:
      case VrState.loading:
        pauseOrPlayVR(pause: true);
        setState(() {
          isVideoLoading = true;
        });
        break;
      case VrState.ready:
        pauseOrPlayVR(pause: false);
        setState(() {
          isVideoLoading = false;
          isVideoReady = true;
        });
        break;
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
    _viewPlayerController.seekTo(0);
  }

  void switchSettingsDisplay(bool show) {
    setState(() {
      _isSettingsShown = show;
    });
  }
}
