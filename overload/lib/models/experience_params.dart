import 'package:overload/models/experience_type.dart';

class ExperienceParams {
  final String url;
  final ExperienceType type;
  final double soundCertainty;

  ExperienceParams({
    required this.url,
    required this.type,
    required this.soundCertainty,
  });
}
