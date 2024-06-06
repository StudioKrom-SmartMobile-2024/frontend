import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:overload/utils/constants.dart';
import 'package:overload/widgets/common/default_header.dart';
import 'package:overload/widgets/experience_cards.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Positioned.fill(
          //   child: Image.asset(
          //     'assets/img/Jorrieborrie.png', //!change this to background png
          //     fit: BoxFit.cover,
          //   ),
          // ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DefaultHeader(
                    onPressSettings: () => context.go('/home/settings'),
                    paddingHorizontal: 0,
                  ),
                  const SizedBox(height: 25),
                  Text("Overstimulating experiences",
                      style: Theme.of(context).textTheme.headlineLarge),
                  const SizedBox(height: 10),
                  Text(
                      "Experience the world as it is for those who struggle with sensory overload on a daily basis.",
                      style: Theme.of(context).textTheme.bodyLarge),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.only(top: 25),
                      children: [
                        ExperienceCards(
                          "The Mall",
                          "Bright lights and colors",
                          "assets/img/homepage-icons-v2/shopping_mall.png",
                          onPress: () => context.go('/home/intro/mall'),
                        ),
                        const SizedBox(height: 25),
                        ExperienceCards(
                          "Train Station",
                          "Transit Rush",
                          "assets/img/homepage-icons-v2/train_station.png",
                          onPress: () => context.go('/home/intro/station'),
                        ),
                        const SizedBox(height: 25),
                        ExperienceCards(
                          "Playground",
                          "Kid's POV",
                          "assets/img/homepage-icons-v2/playground.png",
                          onPress: () => context.go('/home/intro/playground'),
                        ),
                        const SizedBox(height: 25),
                        ExperienceCards(
                          "A Concert",
                          "Live noise and crowd",
                          "assets/img/homepage-icons-v2/stage.png",
                          onPress: () => context.go('/home/intro/concert'),
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
