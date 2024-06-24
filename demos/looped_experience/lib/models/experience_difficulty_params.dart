import 'dart:ui';
import 'package:looped_experience/models/experience_type.dart';

class ExperienceDifficultyParams {
  final String title;
  final ExperienceType type;
  final Color color;
  final String url;

  ExperienceDifficultyParams(
      {required this.title,
      required this.type,
      required this.color,
      required this.url});
}
