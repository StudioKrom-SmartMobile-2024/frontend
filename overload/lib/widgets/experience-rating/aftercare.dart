import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:overload/widgets/common/gradient_button.dart';
import 'package:url_launcher/url_launcher.dart';

class Aftercare extends StatefulWidget {
  final VoidCallback closeAftercare;

  const Aftercare({super.key, required this.closeAftercare});

  @override
  State<Aftercare> createState() => _AftercareState();
}

class _AftercareState extends State<Aftercare> {
  bool _buttonEnabled = false;
  int _remainingTime = 5;
  Timer? _timer;
  final double _heightBetweenItems = 40.0;
  final Uri _url = Uri.parse(
      "https://www.hersenstichting.nl/gevolgen-van-een-hersenaandoening/overprikkeling/");

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        _timer?.cancel();
        _onFinishTimer();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _onFinishTimer() {
    setState(() {
      _buttonEnabled = true;
    });
  }

  void onTapContinueEarly(BuildContext context) {
    if (_buttonEnabled) return;

    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      content: Text(
        AppLocalizations.of(context)!.aftercareAttemptSkip,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      duration: const Duration(milliseconds: 2000),
    ));
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Could not launch $_url'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(AppLocalizations.of(context)!.aftercareTitle,
            style: Theme.of(context).textTheme.headlineMedium),
        SizedBox(
          height: _heightBetweenItems / 2,
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: AppLocalizations.of(context)!.aftercareStart,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              TextSpan(
                text: "Hersen Stichting",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.blueAccent),
                recognizer: TapGestureRecognizer()..onTap = _launchUrl,
              ),
              TextSpan(
                text: AppLocalizations.of(context)!.aftercareEnd,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
        SizedBox(height: _heightBetweenItems),
        GestureDetector(
          onTap: () => onTapContinueEarly(context),
          child: GradientButton(
            onPress: _buttonEnabled ? widget.closeAftercare : null,
            text: _buttonEnabled
                ? AppLocalizations.of(context)!.confirmEnterVR
                : '($_remainingTime)',
          ),
        ),
      ],
    );
  }
}
