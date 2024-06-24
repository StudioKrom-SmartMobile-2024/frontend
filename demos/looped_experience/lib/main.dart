import 'package:flutter/material.dart';
import 'package:looped_experience/models/experience_params.dart';
import 'package:looped_experience/models/experience_type.dart';
import 'package:looped_experience/videoplayer.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final _parameters = ExperienceParams(
        url: 'https://i.imgur.com/3WJFkSt.mp4',
        type: ExperienceType.trainStation,
        soundCertainty: 1.0);

    return MaterialApp(
      home: Scaffold(
        body: VideoPlayerPage(params: _parameters),
      ),
    );
  }
}
