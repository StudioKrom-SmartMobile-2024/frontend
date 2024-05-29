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
                children: [
                  GradientButton(22),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
