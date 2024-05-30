import 'package:flutter/material.dart';
import 'package:overload/widgets/gradient_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: const Placeholder(),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "FEELING OVERWELMED?",
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Gulf"),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Discover the World First-Hand as it is for Those with Sensory Overload",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        GradientButton("Get started now", 28),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
