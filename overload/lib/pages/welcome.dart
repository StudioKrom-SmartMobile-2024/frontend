import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:overload/widgets/animations/intro-animation.dart';
import 'package:overload/widgets/common/gradient_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                color: Theme.of(context).colorScheme.primary,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context)!.welcomeTitle,
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 10),
                      Text(
                        AppLocalizations.of(context)!.welcomeDescription,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 20),
                      GradientButton(
                        text: AppLocalizations.of(context)!.getStarted,
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
