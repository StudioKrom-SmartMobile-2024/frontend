import 'package:flutter/material.dart';
import 'package:overload/widgets/common/cancel_button.dart';
import 'package:overload/widgets/common/gradient_button.dart';

class RateExitFeedback extends StatelessWidget {
  final VoidCallback? onPressCancel;
  final VoidCallback onPressContinue;
  final IconData icon;
  final String title;
  final String description;
  final String? cancelText;
  final String continueText;

  const RateExitFeedback(
      {super.key,
      this.onPressCancel,
      required this.onPressContinue,
      required this.icon,
      required this.title,
      required this.description,
      this.cancelText,
      required this.continueText});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: 25),
            Text(description, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 25),
            Icon(
              icon,
              size: 200,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              onPressCancel != null && cancelText != null
                  ? CancelButton(
                      text: cancelText!,
                      onPress: onPressCancel!,
                    )
                  : const SizedBox(
                      height: 0,
                      width: 0,
                    ),
              Expanded(
                  child: GradientButton(
                      onPress: onPressContinue, text: continueText)),
            ],
          ),
        )
      ],
    );
  }
}
