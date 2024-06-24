import 'package:flutter/material.dart';
import 'package:looped_experience/utils/constants.dart';

class DefaultHeader extends StatelessWidget {
  final Color? color;
  final VoidCallback? onPressBack;
  final VoidCallback? onPressSettings;
  final double paddingHorizontal;

  const DefaultHeader({
    super.key,
    this.color,
    this.onPressBack,
    this.onPressSettings,
    this.paddingHorizontal = 32,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 32,
        horizontal: paddingHorizontal,
      ),
      decoration: BoxDecoration(
        color: color ?? Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (onPressBack != null)
            IconButton(
              icon: const Icon(Icons.arrow_back),
              iconSize: DEFAULT_ICON_SIZE,
              color: Theme.of(context).colorScheme.onPrimary,
              onPressed: onPressBack,
            )
          else
            const SizedBox(),
          if (onPressSettings != null)
            IconButton(
              icon: const Icon(Icons.settings),
              iconSize: DEFAULT_ICON_SIZE,
              color: Theme.of(context).colorScheme.onPrimary,
              onPressed: onPressSettings,
            )
          else
            const SizedBox(),
        ],
      ),
    );
  }
}
