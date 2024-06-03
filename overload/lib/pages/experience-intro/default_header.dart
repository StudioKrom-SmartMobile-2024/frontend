import 'package:flutter/material.dart';
import 'package:overload/constants.dart';

class DefaultHeader extends StatelessWidget {
  final Color? color;
  final Function? onPressBack;
  final Function? onPressSettings;

  const DefaultHeader(
      {super.key, this.color, this.onPressBack, this.onPressSettings});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        decoration: BoxDecoration(color: color ?? Colors.transparent),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          onPressBack != null
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  iconSize: DEFAULT_ICON_SIZE,
                  color: COLOR_BLACK,
                  onPressed: () => onPressBack)
              : const SizedBox(),
          onPressSettings != null
              ? IconButton(
                  icon: const Icon(Icons.settings),
                  iconSize: DEFAULT_ICON_SIZE,
                  color: COLOR_BLACK,
                  onPressed: () => onPressSettings)
              : const SizedBox()
        ]));
  }
}
