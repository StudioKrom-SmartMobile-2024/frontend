import 'package:flutter/material.dart';
import 'package:overload/widgets/gradient_button.dart';

class ConfirmLeaveDialogue extends StatelessWidget {
  final Function onConfirm;
  final Function onCancel;
  final String popupDescription;
  final String confirmText;
  final String cancelText;
  final String popupTitle;

  ConfirmLeaveDialogue({
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
              children: [
                // Icon, Title, Subtitle
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.warning,
                        color: Colors.redAccent,
                        size: 40,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        popupTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        popupDescription,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
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
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(18),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
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
