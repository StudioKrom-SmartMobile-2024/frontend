import 'package:flutter/material.dart';

//Borrowed temporarily from Overload main branch
class GradientButton extends StatelessWidget {
  final double fontSize;
  final String text;
  final Function onPress;

  const GradientButton(
      {super.key,
      required this.onPress,
      required this.text,
      required this.fontSize});

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
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(254, 41, 52, 1),
                      Color.fromRGBO(254, 114, 22, 1),
                    ],
                  ),
                ),
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
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
