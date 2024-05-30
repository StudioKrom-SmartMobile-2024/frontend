import 'package:flutter/material.dart';
import 'package:overload/constants.dart';
import 'package:overload/widgets/gradient_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                const Expanded(
                  flex: 3,
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Placeholder(),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "FEELING OVERWELMED?",
                        style: TITLE_TEXT_STYLE,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Discover the World First-Hand as it is for Those with Sensory Overload",
                        style: BODY_TEXT_STYLE,
                      ),
                      const SizedBox(height: 20),
                      GradientButton(
                        text: "Get started now",
                        onPress: getStarted,
                        icon: const Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  void getStarted() {}
}
