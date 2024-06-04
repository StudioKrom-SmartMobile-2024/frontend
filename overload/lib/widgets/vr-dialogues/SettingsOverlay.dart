import 'package:flutter/material.dart';

class SettingsOverlay extends StatelessWidget {
  final Function cardBoardPressed;
  final Function switchSettingsDisplay;
  bool isVideoVR;

  SettingsOverlay(
      {super.key,
      required this.cardBoardPressed,
      required this.switchSettingsDisplay,
      required this.isVideoVR});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xff151515),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20)),
        ),
        padding: const EdgeInsets.fromLTRB(16, 8, 8, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              iconSize: 36,
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: () => switchSettingsDisplay(false),
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(72, 72, 72, 0.85),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 40,
                    child: Text(
                      isVideoVR ? "360" : "VR",
                      style: const TextStyle(fontSize: 21, color: Colors.white),
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 36,
                    icon: Icon(
                      isVideoVR ? Icons.threesixty : Icons.vrpano,
                      color: Colors.white,
                    ),
                    onPressed: () => cardBoardPressed(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
