import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final double fontSize;
  final String text;

  const GradientButton(this.text, this.fontSize, {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
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
                  textStyle: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                onPressed: () {},
                child: Text(text),
              ),
              Icon(
                Icons.navigate_next,
                color: Colors.black,
                size: fontSize * 1.5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
