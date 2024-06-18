import 'package:flutter/material.dart';
import 'package:overload/utils/constants.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPress;
  final IconData? iconData;
  final bool disabled;

  GradientButton({
    super.key,
    required this.onPress,
    required this.text,
    this.iconData,
  }) : disabled = onPress == null;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: GestureDetector(
        onTap: disabled ? null : onPress,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient:
                      disabled ? DISABLED_OVERLOAD_GRADIENT : OVERLOAD_GRADIENT,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(text,
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: disabled
                                    ? Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.3)
                                    : Theme.of(context).colorScheme.primary,
                              )),
                  if (iconData != null)
                    Icon(
                      iconData,
                      color: disabled
                          ? Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.3)
                          : Theme.of(context).colorScheme.primary,
                      size: DEFAULT_ICON_SIZE,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
