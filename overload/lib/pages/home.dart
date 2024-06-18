import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:overload/utils/constants.dart';
import 'package:overload/widgets/common/default_header.dart';
import 'package:overload/widgets/experience_cards.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: -20,
            child: Image.asset(
              'assets/img/bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DefaultHeader(
                    onPressSettings: () => context.push(SETTINGS_ROUTE),
                    paddingHorizontal: 0,
                  ),
                  const SizedBox(height: 25),
                  Text(
                      AppLocalizations.of(context)!
                          .overstimulatingExperiencesTitle,
                      style: Theme.of(context).textTheme.headlineLarge),
                  const SizedBox(height: 10),
                  Text(
                      AppLocalizations.of(context)!
                          .overstimulatingExperiencesDescription,
                      style: Theme.of(context).textTheme.bodyLarge),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.only(top: 25),
                      children: [
                        ExperienceCards(
                          AppLocalizations.of(context)!.theMallTitle,
                          AppLocalizations.of(context)!.theMallDescriptionShort,
                          "assets/img/homepage-icons-v2/shopping_mall.png",
                          onPress: () =>
                              context.push(INTRO_EXPERIENCE_MALL_ROUTE),
                        ),
                        const SizedBox(height: 25),
                        ExperienceCards(
                          AppLocalizations.of(context)!.theStationTitle,
                          AppLocalizations.of(context)!
                              .theStationDescriptionShort,
                          "assets/img/homepage-icons-v2/train_station.png",
                          onPress: () =>
                              context.push(INTRO_EXPERIENCE_STATION_ROUTE),
                        ),
                        const SizedBox(height: 25),
                        ExperienceCards(
                          AppLocalizations.of(context)!.thePlaygroundTitle,
                          AppLocalizations.of(context)!
                              .thePlaygroundDescriptionShort,
                          "assets/img/homepage-icons-v2/playground.png",
                          onPress: () =>
                              context.push(INTRO_EXPERIENCE_PLAYGROUND_ROUTE),
                        ),
                        const SizedBox(height: 25),
                        ExperienceCards(
                          AppLocalizations.of(context)!.theConcertTitle,
                          AppLocalizations.of(context)!
                              .theConcertDescriptionShort,
                          "assets/img/homepage-icons-v2/stage.png",
                          onPress: () =>
                              context.push(INTRO_EXPERIENCE_CONCERT_ROUTE),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
