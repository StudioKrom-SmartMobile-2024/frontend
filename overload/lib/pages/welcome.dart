import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:overload/utils/constants.dart';
import 'package:overload/widgets/animations/intro-animation.dart';
import 'package:overload/widgets/common/gradient_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            const OverstimulateIntroAnimation(),
            Positioned(
              width: MediaQuery.of(context).size.width,
              bottom: 30,
              child: Container(
                color: COLOR_WHITE,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "FEELING OVERWELMED?",
                        style: TITLE_TEXT_STYLE,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Discover the world first-hand as it is for those suffering from sensory overload",
                        style: BODY_TEXT_STYLE,
                      ),
                      const SizedBox(height: 20),
                      GradientButton(
                        text: "Get started now",
                        onPress: () => context.go("/home"),
                        iconData: Icons.chevron_right,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
