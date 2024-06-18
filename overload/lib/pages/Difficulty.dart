import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:overload/models/experience_difficulty_params.dart';
import 'package:overload/models/experience_params.dart';
import 'package:overload/models/experience_type.dart';
import 'package:overload/utils/constants.dart';
import 'package:overload/widgets/common/default_header.dart';
import 'package:overload/widgets/common/gradient_button.dart';
import 'package:overload/widgets/common/toggle_row.dart';
import 'package:overload/widgets/intensity_buttons.dart';
import 'package:overload/widgets/shapes/wave_painter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DifficultyPage extends StatefulWidget {
  final ExperienceDifficultyParams params;

  DifficultyPage({super.key, required this.params});

  @override
  State<DifficultyPage> createState() => _DifficultyPageState();
}

class _DifficultyPageState extends State<DifficultyPage> {
  double? difficultyModifier;
  Intensity? selectedIntensity;
  bool useGestures = false;

  @override
  Widget build(BuildContext context) {
    void onPressDifficulty(Intensity intensity) {
      setState(() {
        selectedIntensity = intensity;
        switch (intensity) {
          case Intensity.high:
            difficultyModifier = 1.0;
            break;
          case Intensity.medium:
            difficultyModifier = 0.6;
            break;
          case Intensity.low:
            difficultyModifier = 0.3;
            break;
        }
      });
    }

    void openScenario() {
      var parameters = ExperienceParams(
          url: widget.params.url,
          type: widget.params.type,
          soundCertainty: difficultyModifier ?? 1.0);

      context.push(EXPERIENCE_ROUTE, extra: parameters);
    }

    void toggleGestures(bool value) {
      setState(() {
        useGestures = value;
      });
    }

    const paddingBetween = 25.0;

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultHeader(
            onPressBack: () => context.pop(),
            onPressSettings: () => context.push(SETTINGS_ROUTE),
            color: widget.params.color,
          ),
          CustomPaint(
            size: const Size(double.infinity, 100),
            painter: WavePainter(waveColor: widget.params.color),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.params.title,
                    style: Theme.of(context).textTheme.headlineLarge),
                Text(AppLocalizations.of(context)!.selectDifficulty,
                    style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: paddingBetween),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DifficultyButton(
                      onPress: () => onPressDifficulty(Intensity.low),
                      text: AppLocalizations.of(context)!.difficultyEasy,
                      intensity: Intensity.low,
                      isSelected: selectedIntensity == Intensity.low,
                    ),
                    DifficultyButton(
                      onPress: () => onPressDifficulty(Intensity.medium),
                      text: AppLocalizations.of(context)!.difficultyNormal,
                      intensity: Intensity.medium,
                      isSelected: selectedIntensity == Intensity.medium,
                    ),
                    DifficultyButton(
                      onPress: () => onPressDifficulty(Intensity.high),
                      text: AppLocalizations.of(context)!.difficultyHard,
                      intensity: Intensity.high,
                      isSelected: selectedIntensity == Intensity.high,
                    ),
                  ],
                ),
                const SizedBox(height: paddingBetween),
                ToggleSetting(
                  text: AppLocalizations.of(context)!.toggleGestures,
                  isToggled: useGestures,
                  changeValue: toggleGestures,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      "assets/img/shake_gesture.gif",
                      fit: BoxFit.contain,
                      gaplessPlayback: true,
                    ),
                  ),
                ),
                const SizedBox(height: paddingBetween),
                GradientButton(
                    onPress:
                        difficultyModifier != null && widget.params.url != ''
                            ? () => openScenario()
                            : null,
                    text: AppLocalizations.of(context)!.enterExperience)
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
