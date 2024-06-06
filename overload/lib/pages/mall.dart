import 'package:flutter/material.dart';

class MallPage extends StatefulWidget {
  const MallPage({super.key});

  @override
  State<MallPage> createState() => _MallPageState();
}

class _MallPageState extends State<MallPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned.fill(
            child:
                Image.asset('assets/img/Jorrieborrie.png', fit: BoxFit.cover)),
        const Center(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Placeholder(),
                ),
                Expanded(
                  flex: 2,
                  child: Placeholder(),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
