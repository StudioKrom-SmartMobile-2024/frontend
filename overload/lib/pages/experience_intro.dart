import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:overload/utils/constants.dart';
import 'package:overload/models/experience_intro_params.dart';
import 'package:overload/models/experience_params.dart';
import 'package:overload/models/experience_type.dart';
import 'package:overload/widgets/shapes/wave_painter.dart';
import 'package:overload/widgets/common/default_header.dart';
import 'package:overload/widgets/common/gradient_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExperienceIntro extends StatelessWidget {
  final ExperienceIntroParameters params;
  final bool isButtonDisabled;

  ExperienceIntro({super.key, required this.params})
      : isButtonDisabled = params.url == '';

  List<Widget> buildIndicators(BuildContext context) {
    return params.indicators.entries.map((entry) {
      return Chip(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        side: BorderSide.none,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        avatar: Icon(entry.value, color: params.color),
        label: Text(entry.key, style: Theme.of(context).textTheme.bodySmall),
      );
    }).toList();
  }

  List<Widget> buildStrategies(BuildContext context) {
    return params.strategies.entries.map((entry) {
      return Container(
        width: 100,
        height: 125,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.secondary,
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              entry.value,
              color: Theme.of(context).colorScheme.onSecondary,
              size: DEFAULT_ICON_SIZE,
            ),
            Text(
              entry.key,
              style: Theme.of(context).textTheme.bodyMedium,
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
        onPressBack: () => context.pop(),
        onPressSettings: () => context.push(SETTINGS_ROUTE),
        color: params.color,
      ),
      ClipRect(
        child: CustomPaint(
          size: const Size(double.infinity, 100),
          painter: WavePainter(waveColor: params.color),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(params.title,
                style: Theme.of(context).textTheme.headlineLarge),
            Wrap(
              spacing: 10,
              runSpacing: 4,
              children: buildIndicators(context),
            ),
            const SizedBox(height: paddingBetween),
            Text(params.description,
                style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: paddingBetween),
            Text(AppLocalizations.of(context)!.strategiesTitle,
                style: Theme.of(context).textTheme.headlineMedium),
            Text(AppLocalizations.of(context)!.strategiesDescription,
                style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: paddingBetween),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: buildStrategies(context),
            ),
            const SizedBox(height: paddingBetween),
            Row(
              children: [
                const Expanded(flex: 1, child: SizedBox()),
                GradientButton(
                  onPress: isButtonDisabled
                      ? null
                      : () => onPressProceed(context, params),
                  text: AppLocalizations.of(context)!.confirmEnterVR,
                  iconData: Icons.chevron_right,
                ),
              ],
            )
          ],
        )),
      ),
    ])));
  }

  void onPressProceed(BuildContext context, ExperienceIntroParameters params) {
    var parameters = ExperienceParams(
        url: params.url, type: ExperienceType.trainStation, soundCertainty: 1);
    context.push(EXPERIENCE_ROUTE, extra: parameters);
  }
}
