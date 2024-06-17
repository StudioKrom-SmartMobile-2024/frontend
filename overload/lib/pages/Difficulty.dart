import 'package:flutter/material.dart';
import 'package:overload/widgets/intensity_buttons.dart';

class DifficultyPage extends StatefulWidget {
  const DifficultyPage({super.key});

  @override
  State<DifficultyPage> createState() => _DifficultyPageState();
}

class _DifficultyPageState extends State<DifficultyPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Stack(
      children: [
        Positioned.fill(child: Placeholder()),
        Center(
          child: Padding(
            padding: EdgeInsets.all(27),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Placeholder(),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DiffucultyButton(
                        onPress: null,
                        text: "Easy",
                        intensity: Intensity.low,
                      ),
                      DiffucultyButton(
                        onPress: null,
                        text: "Medium",
                        intensity: Intensity.medium,
                      ),
                      DiffucultyButton(
                        onPress: null,
                        text: "Hard",
                        intensity: Intensity.high,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
