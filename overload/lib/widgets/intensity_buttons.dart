import 'package:flutter/material.dart';
import 'package:overload/utils/constants.dart';

class DifficultyButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPress;
  final Intensity intensity;
  final bool isSelected;

  const DifficultyButton({
    super.key,
    required this.onPress,
    required this.text,
    required this.intensity,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: onPress,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
          ),
          width: double.infinity,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: _getGradientColor(intensity),
                    borderRadius: BorderRadius.circular(40),
                    border: isSelected
                        ? Border.all(
                            color: Theme.of(context).colorScheme.onSecondary,
                            width: 2.0)
                        : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                  child: Text(text, //needs updated text style
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.black,
                          )),
                ),
              ),
            ],
          ),
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
