import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:overload/models/experience_params.dart';
import 'package:overload/models/experience_type.dart';
import 'package:overload/utils/constants.dart';
import 'package:overload/utils/sound_manager.dart';
import 'package:overload/widgets/vr-overlays/confirmation_dialogue.dart';
import 'package:overload/widgets/vr-overlays/settings_overlay.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:vr_player/vr_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  late final CountdownController _countdownController =
      CountdownController(autoStart: true);
  late VrPlayerController _viewPlayerController;
  late double _playerWidth;
  late double _playerHeight;

  bool _isShowingCountdown = false;
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
          Positioned(
              right: 8,
              bottom: 8,
              child: IconButton(
                iconSize: 36,
                icon: Icon(
                  Icons.logout,
                  color: _isShowingCountdown
                      ? Color.fromARGB(44, 244, 67, 54)
                      : Colors.red,
                ),
                onPressed: _isShowingCountdown ? null : () => exitExperience(),
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
                    iconSize: DEFAULT_ICON_SIZE,
                    icon: Icon(
                      Icons.settings,
                      color: _isShowingCountdown
                          ? Color.fromARGB(44, 255, 255, 255)
                          : Colors.white,
                    ),
                    onPressed: _isShowingCountdown
                        ? null
                        : () => switchSettingsDisplay(true),
                  )),
          if (_isShowingCountdown)
            Positioned(
              left: _playerWidth * 0.125,
              top: _playerHeight * 0.125,
              width: _playerWidth * 0.75,
              height: _playerHeight * 0.75,
              child: Center(
                child: Countdown(
                  controller: _countdownController,
                  seconds: 5,
                  build: (_, double time) => Text(
                    time.floor().toString(),
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(fontSize: 200),
                  ),
                  interval: const Duration(seconds: 1),
                  onFinished: () {
                    onCountdownEnd();
                  },
                ),
              ),
            ),
          if (isVideoLoading)
            const Center(
              child: SpinKitDualRing(
                color: Colors.white,
                size: 50.0,
              ),
            ),
          if (_isShowingConfirmExit)
            ConfirmationDialogue(
                onConfirm: confirmLeave,
                onCancel: cancelLeave,
                popupDescription:
                    AppLocalizations.of(context)!.exitExperienceDescription,
                confirmText: AppLocalizations.of(context)!.exitVRConfirm,
                cancelText: AppLocalizations.of(context)!.exitVRCancel,
                popupTitle: AppLocalizations.of(context)!.exitExperienceTitle),
          if (_isDisclaimerShowing)
            ConfirmationDialogue(
              onConfirm: confirmStart,
              onCancel: cancelStart,
              popupDescription:
                  AppLocalizations.of(context)!.disclaimerDescription,
              confirmText: AppLocalizations.of(context)!.startVRConfirm,
              cancelText: AppLocalizations.of(context)!.exitVRCancel,
              popupTitle: AppLocalizations.of(context)!.disclaimerTitle,
            ),
        ],
      ),
    );
  }

  void cancelStart() {
    switch (widget.params.type) {
      case ExperienceType.trainStation:
        context.go(DIFFICULTY_STATION_ROUTE);
        break;
      case ExperienceType.mall:
        context.go(DIFFICULTY_MALL_ROUTE);
        break;
      case ExperienceType.playground:
        context.go(DIFFICULTY_PLAYGROUND_ROUTE);
        break;
      case ExperienceType.concert:
        context.go(DIFFICULTY_CONCERT_ROUTE);
        break;
    }
  }

  void onCountdownEnd() {
    setState(() {
      _isShowingCountdown = false;
    });
    pauseOrPlayVR(pause: false);
    cardBoardPressed();
  }

  void confirmStart() {
    setState(() {
      _isDisclaimerShowing = false;
      _isShowingCountdown = true;
    });
    _countdownController.start();
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

    context.push(RATE_ROUTE);

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
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
      case VrState.buffering:
      case VrState.loading:
        pauseOrPlayVR(pause: true);
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
