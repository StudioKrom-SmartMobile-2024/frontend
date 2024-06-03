import 'package:flutter/material.dart';
import 'package:overload/constants.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final Function onPress;
  final IconData? iconData;

  GradientButton({
    super.key,
    required this.onPress,
    required this.text,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: GestureDetector(
        onTap: onPress(),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(gradient: OVERLOAD_GRADIENT),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(text, style: SUBHEADER_TEXT_STYLE),
                  if (iconData != null)
                    Icon(
                      iconData,
                      color: Colors.black,
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
