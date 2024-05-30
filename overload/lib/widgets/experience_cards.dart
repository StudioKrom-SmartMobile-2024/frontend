import 'package:flutter/material.dart';

class ExperienceCards extends StatelessWidget {
  final String title;
  final String text;
  final String iconPath;

  const ExperienceCards(this.title, this.text, this.iconPath, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 106,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color.fromRGBO(217, 217, 217, 59),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 59,
            height: 59,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Image.asset(
              iconPath,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Gulf"),
              ),
              Text(
                text,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Icon(Icons.east, color: Colors.black, size: 40)
        ],
      ),
    );
  }
}
