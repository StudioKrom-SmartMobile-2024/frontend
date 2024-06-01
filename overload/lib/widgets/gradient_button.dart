import 'package:flutter/material.dart';
import 'package:overload/constants.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final Function onPress;
  final Icon? icon;

  GradientButton({
    super.key,
    required this.onPress,
    required this.text,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(gradient: OVERLOAD_GRADIENT),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(18),
                  ),
                  onPressed: () => onPress(),
                  child: Text(text, style: SUBHEADER_TEXT_STYLE),
                ),
                icon != null
                    ? const Icon(
                        Icons.navigate_next,
                        color: Colors.black,
                        size: SUBHEADER_FONTSIZE * 1.5,
                      )
                    : const SizedBox()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
