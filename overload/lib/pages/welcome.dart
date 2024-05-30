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
    return const Scaffold(
      body: Center(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 26),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Placeholder(),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "FEELING OVERWELMED?",
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Gulf"),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Discover the World First-Hand as it is for Those with Sensory Overload",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      GradientButton("Get started now", 28),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
