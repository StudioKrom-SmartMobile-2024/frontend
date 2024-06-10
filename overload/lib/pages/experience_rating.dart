import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:overload/utils/constants.dart';
import 'package:overload/widgets/common/default_header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:overload/widgets/experience-rating/rate-exit.dart';
import 'package:overload/widgets/experience-rating/rate_exit_feedback.dart';

class RateExperience extends StatefulWidget {
  RateExperience({super.key});

  @override
  State<RateExperience> createState() => _RateExperienceState();
}

class _RateExperienceState extends State<RateExperience> {
  bool _showRating = true;
  bool _showSkipFeedback = false;
  bool _showThanks = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: -20,
            child: Image.asset(
              'assets/img/bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DefaultHeader(
                  onPressSettings: () => context.go('/home/settings'),
                  paddingHorizontal: 0,
                ),
                const SizedBox(height: 25),
                if (_showRating)
                  RateExit(
                    skipRating: skipRating,
                    sendRating: sendRating,
                  ),
                if (_showSkipFeedback)
                  RateExitFeedback(
                    onPressContinue: () => goHome(context),
                    onPressCancel: cancelSkipRating,
                    icon: Icons.sentiment_dissatisfied,
                    title: AppLocalizations.of(context)!.confirmSkipTitle,
                    description:
                        AppLocalizations.of(context)!.confirmSkipDescription,
                    continueText: AppLocalizations.of(context)!.skipFeedbackYes,
                    cancelText: AppLocalizations.of(context)!.skipFeedbackNo,
                  ),
                if (_showThanks)
                  RateExitFeedback(
                    onPressContinue: () => goHome(context),
                    icon: Icons.sentiment_very_satisfied,
                    title: AppLocalizations.of(context)!.feedbackReceivedTitle,
                    description:
                        AppLocalizations.of(context)!.confirmSkipDescription,
                    continueText: AppLocalizations.of(context)!.home,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void skipRating() {
    setState(() {
      _showRating = false;
      _showSkipFeedback = true;
      _showThanks = false;
    });
  }

  void cancelSkipRating() {
    setState(() {
      _showRating = true;
      _showSkipFeedback = false;
      _showThanks = false;
    });
  }

  void sendRating() {
    setState(() {
      _showRating = false;
      _showSkipFeedback = false;
      _showThanks = true;
    });
  }

  void goHome(BuildContext context) {
    context.go(HOME_ROUTE);
  }
}
