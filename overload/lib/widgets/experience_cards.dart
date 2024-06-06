import 'package:flutter/material.dart';
import 'package:overload/utils/constants.dart';

class ExperienceCards extends StatelessWidget {
  final String title;
  final String text;
  final String iconPath;
  final VoidCallback onPress;

  const ExperienceCards(this.title, this.text, this.iconPath,
      {super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
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
              child: Center(
                child: Image.asset(
                  iconPath,
                  width: 34,
                  height: 34,
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      text,
                      style: Theme.of(context).textTheme.bodyLarge,
                      softWrap: true,
                    ),
                  ],
                ),
              ),
            ),
            Icon(Icons.east,
                color: Theme.of(context).colorScheme.onPrimary,
                size: DEFAULT_ICON_SIZE),
          ],
        ),
      ),
    );
  }
}
