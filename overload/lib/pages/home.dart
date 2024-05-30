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
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Placeholder(),
              ),
              Expanded(
                flex: 6,
                child: Placeholder(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
