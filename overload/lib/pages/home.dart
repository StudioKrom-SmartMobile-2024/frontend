import 'package:flutter/material.dart';
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
          Positioned.fill(
            child: Image.asset(
              'assets/img/Jorrieborrie.png', //change this to background png
              fit: BoxFit.cover,
            ),
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Scaffold(
                        backgroundColor: Colors.transparent,
                        body: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: SizedBox(
                                child: Icon(
                                  Icons.settings,
                                  color: Colors.black,
                                  size: 40,
                                ),
                              ),
                            ),
                            Text(
                              "Overstimulating experiences",
                              style: TextStyle(
                                  fontSize: 34,
                                  fontFamily: "Gulf",
                                  color: Colors.black),
                            ),
                            SizedBox(height: 10),
                            Text(
                                "Experience the world as it is for those who struggle with sensory overload on a daily basis.",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Column(
                        children: [
                          ExperienceCards(
                              "The Mall",
                              "Bright lights and colors",
                              "assets/img/homepage icons/mall.png"),
                          SizedBox(height: 20),
                          ExperienceCards("Train Station", "Transit Rush",
                              "assets/img/homepage icons/train.png"),
                          SizedBox(height: 20),
                          ExperienceCards("The Playground", "Kid's POV",
                              "assets/img/homepage icons/playground.png"),
                          SizedBox(height: 20),
                          ExperienceCards("A Concert", "Live noise and crowd",
                              "assets/img/homepage icons/concert.png"),
                        ],
                      ),
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
