import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  final VoidCallback onPress;
  final String text;

  const CancelButton({super.key, required this.onPress, required this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => onPress(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Text(text,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: Colors.black)),
        ),
      ),
    );
  }
}
