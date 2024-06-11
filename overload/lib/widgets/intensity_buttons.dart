import 'package:flutter/material.dart';
import 'package:overload/utils/constants.dart';

class DiffucultyButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPress;
  final bool disabled;
  final Intensity intensity;

  const DiffucultyButton({
    super.key,
    required this.onPress,
    required this.text,
    required this.intensity,
  }) : disabled = onPress == null;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: GestureDetector(
        onTap: disabled ? null : onPress,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: _getGradientColor(intensity),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(text,
                  style: SUBHEADER_TEXT_STYLE.copyWith(
                    color: Colors.black,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

LinearGradient _getGradientColor(Intensity intensity) {
  switch (intensity) {
    case Intensity.low:
      return OVERLOAD_GRADIENT_LOW;
    case Intensity.medium:
      return OVERLOAD_GRADIENT_MEDIUM;
    case Intensity.high:
      return OVERLOAD_GRADIENT_HIGH;
  }
}

enum Intensity { low, medium, high }
