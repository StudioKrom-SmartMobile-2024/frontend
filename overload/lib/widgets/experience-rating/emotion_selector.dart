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
            assetQuery: "assets/img/emoji/image.png",
            description: AppLocalizations.of(context)!.feelingDisoriented,
            //color: Colors.red,
            selected: selectedEmotion == 'Good',
            onTap: () => _selectEmotion('Good'),
          ),
          EmotionCard(
            assetQuery: "assets/img/emoji/icons8-light-on-96.png",
            description: AppLocalizations.of(context)!.feelingInformed,
            //color: Colors.yellow,
            selected: selectedEmotion == 'Normal',
            onTap: () => _selectEmotion('Normal'),
          ),
          EmotionCard(
            assetQuery: "assets/img/emoji/icons8-blushing-96.png",
            description: AppLocalizations.of(context)!.feelingRelatable,
            //color: Colors.green,
            selected: selectedEmotion == 'Bad',
            onTap: () => _selectEmotion('Bad'),
          ),
        ],
      ),
    );
  }
}

class EmotionCard extends StatelessWidget {
  final String assetQuery;
  final String description;
  final bool selected;
  //final Color color;
  final VoidCallback onTap;

  const EmotionCard({
    super.key,
    required this.assetQuery,
    required this.description,
    //required this.color,
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
            Image.asset(
              assetQuery,
              //color: color,
              width: selected ? 70 : 50,
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
