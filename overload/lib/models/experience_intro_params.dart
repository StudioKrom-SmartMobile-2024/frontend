import 'package:flutter/material.dart';

class ExperienceIntroParameters {
  final String title;
  final String description;
  final Color color;
  final Map<String, IconData> strategies;
  final Map<String, IconData> indicators;
  final String url;

  ExperienceIntroParameters(
      {required this.title,
      required this.description,
      required this.color,
      required this.strategies,
      required this.indicators,
      required this.url});
}
