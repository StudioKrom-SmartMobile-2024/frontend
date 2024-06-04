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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(text,
                      style: SUBHEADER_TEXT_STYLE.copyWith(
                        color: disabled ? Colors.black26 : Colors.black,
                      )),
                  if (iconData != null)
                    Icon(
                      iconData,
                      color: disabled ? Colors.black26 : Colors.black,
                      size: DEFAULT_ICON_SIZE,
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
