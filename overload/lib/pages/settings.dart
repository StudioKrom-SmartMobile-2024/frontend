import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:overload/main.dart';
import 'package:overload/utils/constants.dart';
import 'package:overload/widgets/common/default_header.dart';
import 'package:overload/widgets/common/toggle_row.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;
  bool useGestures = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('darkmode') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    const heightBetween = 25.0;

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultHeader(
                    onPressBack: () => context.pop(),
                    paddingHorizontal: 0,
                  ),
                  Text(
                    "Settings",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: heightBetween),
                  ToggleSetting(
                    text: 'Dark mode',
                    isToggled: isDarkMode,
                    changeValue: toggleDarkMode,
                  ),
                  const SizedBox(height: heightBetween),
                  ToggleSetting(
                    text: 'Shake head to pause video',
                    isToggled: useGestures,
                    changeValue: toggleGestures,
                    child: const SizedBox(
                      height: 150,
                      child: Placeholder(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void toggleGestures(bool value) {
    setState(() {
      useGestures = value;
    });
  }

  Future<void> toggleDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkmode', !isDarkMode);
    setState(() {
      isDarkMode = value ?? false;
    });
    print(prefs.getBool('darkmode'));
    isDarkMode
        ? MainApp.of(context).changeTheme(ThemeMode.dark)
        : MainApp.of(context).changeTheme(ThemeMode.light);
  }
}
