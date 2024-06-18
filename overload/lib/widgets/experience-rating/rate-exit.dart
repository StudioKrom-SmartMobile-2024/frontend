import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:overload/widgets/common/cancel_button.dart';
import 'package:overload/widgets/common/gradient_button.dart';
import 'package:overload/widgets/experience-rating/emotion_selector.dart';

class RateExit extends StatefulWidget {
  final VoidCallback skipRating;
  final VoidCallback sendRating;

  RateExit({
    super.key,
    required this.skipRating,
    required this.sendRating,
  });

  @override
  State<RateExit> createState() => _RateExitState();
}

class _RateExitState extends State<RateExit> {
  bool _hasRated = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.rateExperienceTitle,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 25),
        Text(
          AppLocalizations.of(context)!.rateExperienceDescription,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 25),
        Text(
          AppLocalizations.of(context)!.rateExperienceCommentTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 25),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(15),
          ),
          height: 150,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextField(
              minLines: 5,
              maxLines: 5,
              showCursor: true,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
              decoration: InputDecoration(
                labelText: 'Write your comment here...',
                labelStyle: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onSecondary
                      .withOpacity(0.5),
                ),
                alignLabelWithHint: true,
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        const SizedBox(height: 25),
        Text(
          AppLocalizations.of(context)!.feelingQuestion,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 25),
        EmotionSelector(
          onSetRating: onSetRating,
        ),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CancelButton(
                text: AppLocalizations.of(context)!.skipRatingButton,
                onPress: widget.skipRating,
              ),
            ),
            const SizedBox(width: 25),
            Expanded(
              child: GradientButton(
                onPress: _hasRated ? widget.sendRating : null,
                text: AppLocalizations.of(context)!.confirmRatingButton,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void onSetRating() {
    setState(() {
      _hasRated = true;
    });
  }
}
