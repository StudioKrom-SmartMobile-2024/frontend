import 'package:flutter/material.dart';
import 'package:overload/utils/constants.dart';
import 'package:overload/widgets/common/gradient_button.dart';

class ConfirmationDialogue extends StatelessWidget {
  final Function onConfirm;
  final Function onCancel;
  final String popupDescription;
  final String confirmText;
  final String cancelText;
  final String popupTitle;

  ConfirmationDialogue({
    Key? key,
    required this.onConfirm,
    required this.onCancel,
    required this.popupDescription,
    required this.confirmText,
    required this.cancelText,
    required this.popupTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _popUpWidth = MediaQuery.of(context).size.width;
    double _popUpHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            color: Colors.black.withOpacity(0.8),
          ),
        ),
        Positioned(
          left: _popUpWidth * 0.125,
          top: _popUpHeight * 0.125,
          width: _popUpWidth * 0.75,
          height: _popUpHeight * 0.75,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xff373737),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon, Title, Subtitle
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.warning,
                        color: Colors.redAccent,
                        size: DEFAULT_ICON_SIZE,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(popupTitle,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(color: Colors.white)),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        popupDescription,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: BODY_FONTSIZE,
                            fontFamily: FONT_ROBOTO,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => onCancel(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Text(cancelText, style: SUBHEADER_TEXT_STYLE),
                        ),
                      ),
                    ),
                    const SizedBox(width: 32),
                    Expanded(
                      child: GradientButton(
                        onPress: () => onConfirm(),
                        text: confirmText,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
