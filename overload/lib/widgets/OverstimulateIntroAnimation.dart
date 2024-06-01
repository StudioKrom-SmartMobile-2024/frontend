import 'dart:math';
import 'package:flutter/material.dart';
import 'package:overload/constants.dart';
import 'package:overload/widgets/MarqueeEffect.dart';

class OverstimulateIntroAnimation extends StatefulWidget {
  const OverstimulateIntroAnimation({super.key});

  @override
  State<OverstimulateIntroAnimation> createState() =>
      _OverstimulateIntroAnimationState();
}

class _OverstimulateIntroAnimationState
    extends State<OverstimulateIntroAnimation> {
  final _random = Random();
  late AnimationController _controller;

  late var horizontalSpaceBetween = _random.nextInt(15) + 15;

  final itemsToGenerate = 15;
  final widgetHeight = 50.0;
  final marginLeft = 0.0;
  final widgetMaxSpeed = 35;
  final widgetMinSpeed = 10;
  final verticalSpaceBetween = 15.0;
  final widgetHorizontalSpaceMin = 15.0;
  final widgetHorizontalSpaceMax = 40;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            SizedBox(
              height: verticalSpaceBetween,
            ),
            MarqueeEffect(
              marginLeft: marginLeft,
              betweenSpacing: _random.nextInt(widgetHorizontalSpaceMax) +
                  widgetHorizontalSpaceMin,
              width: constraints.maxWidth,
              height: widgetHeight,
              speedRate: _random.nextDouble() * widgetMaxSpeed + widgetMinSpeed,
              children:
                  List.generate(itemsToGenerate, (index) => getRandomElement()),
            ),
            SizedBox(
              height: verticalSpaceBetween,
            ),
            MarqueeEffect(
              marginLeft: marginLeft,
              betweenSpacing: _random.nextInt(widgetHorizontalSpaceMax) +
                  widgetHorizontalSpaceMin,
              width: constraints.maxWidth,
              height: widgetHeight,
              speedRate: _random.nextDouble() * widgetMaxSpeed + widgetMinSpeed,
              children:
                  List.generate(itemsToGenerate, (index) => getRandomElement()),
            ),
            SizedBox(
              height: verticalSpaceBetween,
            ),
            MarqueeEffect(
              marginLeft: marginLeft,
              betweenSpacing: _random.nextInt(widgetHorizontalSpaceMax) +
                  widgetHorizontalSpaceMin,
              width: constraints.maxWidth,
              height: widgetHeight,
              speedRate: _random.nextDouble() * widgetMaxSpeed + widgetMinSpeed,
              children:
                  List.generate(itemsToGenerate, (index) => getRandomElement()),
            ),
            SizedBox(
              height: verticalSpaceBetween,
            ),
            MarqueeEffect(
              marginLeft: marginLeft,
              betweenSpacing: _random.nextInt(widgetHorizontalSpaceMax) +
                  widgetHorizontalSpaceMin,
              width: constraints.maxWidth,
              height: widgetHeight,
              speedRate: _random.nextDouble() * widgetMaxSpeed + widgetMinSpeed,
              children:
                  List.generate(itemsToGenerate, (index) => getRandomElement()),
            ),
            SizedBox(
              height: verticalSpaceBetween,
            ),
            MarqueeEffect(
              marginLeft: marginLeft,
              betweenSpacing: _random.nextInt(widgetHorizontalSpaceMax) +
                  widgetHorizontalSpaceMin,
              width: constraints.maxWidth,
              height: widgetHeight,
              speedRate: _random.nextDouble() * widgetMaxSpeed + widgetMinSpeed,
              children:
                  List.generate(itemsToGenerate, (index) => getRandomElement()),
            ),
            SizedBox(
              height: verticalSpaceBetween,
            ),
            MarqueeEffect(
              marginLeft: marginLeft,
              betweenSpacing: _random.nextInt(widgetHorizontalSpaceMax) +
                  widgetHorizontalSpaceMin,
              width: constraints.maxWidth,
              height: widgetHeight,
              speedRate: _random.nextDouble() * widgetMaxSpeed + widgetMinSpeed,
              children:
                  List.generate(itemsToGenerate, (index) => getRandomElement()),
            ),
            SizedBox(
              height: verticalSpaceBetween,
            ),
            MarqueeEffect(
              marginLeft: marginLeft,
              betweenSpacing: _random.nextInt(widgetHorizontalSpaceMax) +
                  widgetHorizontalSpaceMin,
              width: constraints.maxWidth,
              height: widgetHeight,
              speedRate: _random.nextDouble() * widgetMaxSpeed + widgetMinSpeed,
              children:
                  List.generate(itemsToGenerate, (index) => getRandomElement()),
            ),
          ],
        );
      },
    );
  }

  Widget getRandomElement() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        alignment: Alignment.center,
        height: widgetHeight,
        width: 120,
        padding: const EdgeInsets.all(8),
        color: getRandomColor(),
        child: Text(
          selectRandomText(),
          style: TextStyle(
              fontWeight: selectRandomFontWeight(),
              fontFamily: getRandomyFontFamily()),
        ),
      ),
    );
  }

  Color getRandomColor() {
    return colorOptions[_random.nextInt(colorOptions.length)];
  }

  String selectRandomText() {
    return textOptions[_random.nextInt(textOptions.length)];
  }

  FontWeight selectRandomFontWeight() {
    return fontWeightOptions[_random.nextInt(fontWeightOptions.length)];
  }

  String getRandomyFontFamily() {
    return fontFamilyOptions[_random.nextInt(fontFamilyOptions.length)];
  }

  final colorOptions = [COLOR_ORANGE, COLOR_GREEN, COLOR_BLUE];

  final fontWeightOptions = [
    FontWeight.bold,
    FontWeight.w100,
    FontWeight.w200,
    FontWeight.w300,
    FontWeight.w400,
    FontWeight.w500,
    FontWeight.w600,
    FontWeight.w700,
    FontWeight.w800,
    FontWeight.w900,
    FontWeight.normal,
  ];

  final fontFamilyOptions = [
    "Roboto",
    "Gulf",
    "Dancing",
    "EduTasBeginner",
    "JostItalic",
    "Jost",
    "KarlaItalic",
    "Karla",
    "SignikaNegative",
    "UbuntuSansMonoItalic",
    "UbuntuSansMono"
  ];

  final textOptions = [
    "Loud",
    "Bright",
    "Flashing",
    "Buzzing",
    "Crowded",
    "Chaotic",
    "Blurry",
    "Dizzy",
    "Confusing",
    "Jumbled",
    "Overwhelmed",
    "Noise",
    "Clashing",
    "Sharp",
    "Intense",
    "Rapid",
    "Pulsing",
    "Distorted",
    "Blinding",
    "Echoing",
    "Vibrating",
    "Spinning",
    "Disturbing",
    "Anxious",
    "Stressful",
    "Deafening",
    "Jagged",
    "Frenzied",
    "Irritating",
    "Hectic",
    "Shattering",
    "Explosive",
    "Unbearable",
    "Jarring",
    "Disorienting",
    "Crushing",
    "Overpowering",
    "Jostling",
    "Frenetic"
  ];
}
