import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmotionSelector extends StatefulWidget {
  final VoidCallback onSetRating;
  const EmotionSelector({super.key, required this.onSetRating});

  @override
  _EmotionSelectorState createState() => _EmotionSelectorState();
}

class _EmotionSelectorState extends State<EmotionSelector> {
  String? selectedEmotion;

  void _selectEmotion(String emotion) {
    setState(() {
      selectedEmotion = emotion;
    });
    widget.onSetRating();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          EmotionCard(
            icon: Icons.sentiment_very_satisfied,
            description: AppLocalizations.of(context)!.feelingGood,
            color: Colors.green,
            selected: selectedEmotion == 'Good',
            onTap: () => _selectEmotion('Good'),
          ),
          EmotionCard(
            icon: Icons.sentiment_neutral,
            description: AppLocalizations.of(context)!.feelingNormal,
            color: Colors.yellow,
            selected: selectedEmotion == 'Normal',
            onTap: () => _selectEmotion('Normal'),
          ),
          EmotionCard(
            icon: Icons.sentiment_very_dissatisfied,
            description: AppLocalizations.of(context)!.feelingBad,
            color: Colors.red,
            selected: selectedEmotion == 'Bad',
            onTap: () => _selectEmotion('Bad'),
          ),
        ],
      ),
    );
  }
}

class EmotionCard extends StatelessWidget {
  final IconData icon;
  final String description;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const EmotionCard({
    super.key,
    required this.icon,
    required this.description,
    required this.color,
    required this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: selected ? 70 : 50,
            ),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
