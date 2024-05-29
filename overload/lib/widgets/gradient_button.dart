import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final double fontSize;

  const GradientButton(this.fontSize, {super.key});

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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  textStyle: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                onPressed: () {},
                child: const Text('Get started now'),
              ),
              SizedBox(
                width: fontSize,
                height: fontSize,
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                  size: fontSize,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
