import 'package:flutter/material.dart';
import 'package:overload/constants.dart';
import 'package:overload/pages/experience-intro/wave_painter.dart';
import 'package:overload/pages/experience-intro/default_header.dart';
import 'package:overload/widgets/gradient_button.dart';

class ExperienceIntro extends StatelessWidget {
  final String title;
  final Map<String, IconData> overstimulationIndicators;
  final String description;
  final Map<String, IconData> strategies;
  final Color color;

  const ExperienceIntro(
      {super.key,
      required this.overstimulationIndicators,
      required this.title,
      required this.description,
      required this.strategies,
      required this.color});

  List<Widget> buildIndicators() {
    return overstimulationIndicators.entries.map((entry) {
      return Chip(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        side: BorderSide.none,
        backgroundColor: COLOR_GRAY,
        avatar: Icon(entry.value, color: color),
        label: Text(entry.key, style: DETAILS_TEXT_STYLE),
      );
    }).toList();
  }

  List<Widget> buildStrategies() {
    return strategies.entries.map((entry) {
      return Container(
        width: 100,
        height: 125,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: COLOR_GRAY,
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              entry.value,
              color: COLOR_BLACK,
              size: DEFAULT_ICON_SIZE,
            ),
            Text(
              entry.key,
              style: BODY_TEXT_STYLE,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    const paddingBetween = 32.0;

    return Scaffold(
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      DefaultHeader(
        onPressBack: onPressBack,
        onPressSettings: onPressSettings,
        color: color,
      ),
      ClipRect(
        child: CustomPaint(
          size: const Size(double.infinity, 100),
          painter: WavePainter(waveColor: color),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: HEADER_TEXT_STYLE),
            Wrap(
              spacing: 10,
              runSpacing: 4,
              children: buildIndicators(),
            ),
            const SizedBox(height: paddingBetween),
            Text(description, style: BODY_TEXT_STYLE),
            const SizedBox(height: paddingBetween),
            const Text('Strategies', style: HEADER_TEXT_STYLE),
            const Text(
                "If you notice that you or a close one experiences sensory issues in such environment these are common helping tricks:",
                style: BODY_TEXT_STYLE),
            const SizedBox(height: paddingBetween),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: buildStrategies(),
            ),
            const SizedBox(height: paddingBetween),
            Row(
              children: [
                const Expanded(flex: 1, child: SizedBox()),
                GradientButton(
                  onPress: onPressProceed,
                  text: "Proceed",
                  iconData: Icons.chevron_right,
                ),
              ],
            )
          ],
        )),
      ),
    ])));
  }

  void onPressProceed() {}
  void onPressBack() {}
  void onPressSettings() {}
}
