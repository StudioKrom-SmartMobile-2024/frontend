import 'package:flutter/material.dart';
import 'package:overload/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsOverlay extends StatelessWidget {
  final VoidCallback cardBoardPressed;
  final Function switchSettingsDisplay;
  bool isVideoVR;

  SettingsOverlay({
    super.key,
    required this.cardBoardPressed,
    required this.switchSettingsDisplay,
    required this.isVideoVR,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: Container(
        decoration: const BoxDecoration(
          color: COLOR_BLACK,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20)),
        ),
        padding: const EdgeInsets.fromLTRB(16, 8, 8, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              iconSize: DEFAULT_ICON_SIZE,
              icon: const Icon(
                Icons.close,
                color: COLOR_WHITE,
              ),
              onPressed: () => switchSettingsDisplay(false),
            ),
            InkWell(
              onTap: () => cardBoardPressed(),
              child: Container(
                decoration: BoxDecoration(
                  color: COLOR_GRAY,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 60,
                      child: Text(
                        isVideoVR ? "VR" : "360",
                        style:
                            const TextStyle(fontSize: 21, color: Colors.white),
                      ),
                    ),
                    Icon(
                      isVideoVR ? Icons.vrpano : Icons.threesixty,
                      size: DEFAULT_ICON_SIZE,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
