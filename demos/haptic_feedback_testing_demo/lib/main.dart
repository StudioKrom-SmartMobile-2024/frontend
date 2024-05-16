import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  double duration = 0;
  double amplitude = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Demo of Vibration", style: TextStyle(fontSize: 24)),
              SizedBox(height: 128),
              ElevatedButton(
                onPressed: () {
                  Vibration.vibrate(duration: 37, amplitude: 64);
                },
                child: Text('Light vibration'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Vibration.vibrate(duration: 60, amplitude: 128);
                },
                child: Text('Medium vibration'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Vibration.vibrate(duration: 120, amplitude: 255);
                },
                child: Text('Heavy vibration'),
              ),
              SizedBox(height: 32),
              Column(
                children: [
                  Slider(
                    min: 0,
                    max: 200,
                    value: duration,
                    onChanged: (value) {
                      setState(() {
                        duration = value;
                      });
                    },
                  ),
                  SizedBox(height: 8),
                  Text('Duration: ${duration.toInt()}'),
                ],
              ),
              SizedBox(height: 16),
              Column(
                children: [
                  Slider(
                    min: 0,
                    max: 255,
                    value: amplitude,
                    onChanged: (value) {
                      setState(() {
                        amplitude = value;
                      });
                    },
                  ),
                  SizedBox(height: 8),
                  Text('amplitude: ${amplitude.toInt()}'),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Vibration.vibrate(
                      duration: duration.toInt(), amplitude: amplitude.toInt());
                },
                child: Text('Custom vibration'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
