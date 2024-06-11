import 'package:flutter/material.dart';

class ToggleSetting extends StatelessWidget {
  final String text;
  final bool isToggled;
  final Function changeValue;
  final Widget? child;

  const ToggleSetting(
      {super.key,
      required this.text,
      required this.isToggled,
      required this.changeValue,
      this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 0, 16, child != null ? 16 : 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              //! Have to override the theming locally to change the border color to transparent.
              Theme(
                data: ThemeData(
                  useMaterial3: true,
                ).copyWith(
                  colorScheme: Theme.of(context)
                      .colorScheme
                      .copyWith(outline: Colors.transparent),
                ),
                child: Switch(
                  value: isToggled,
                  activeColor: Colors.white,
                  activeTrackColor: Colors.green,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.grey,
                  onChanged: (bool value) {
                    changeValue(value);
                  },
                ),
              ),
            ],
          ),
          child ?? const SizedBox(),
        ],
      ),
    );
  }
}
