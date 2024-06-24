import 'package:flutter/material.dart';
import 'package:looped_experience/models/experience_type.dart';

class ExperienceIntroParameters {
  final String title;
  final String description;
  final Color color;
  final Map<String, IconData> strategies;
  final Map<String, IconData> indicators;
  final String url;
  final ExperienceType type;

  ExperienceIntroParameters(
      {required this.title,
      required this.description,
      required this.color,
      required this.strategies,
      required this.indicators,
      required this.url,
      required this.type});
}
