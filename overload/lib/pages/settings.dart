import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:overload/main.dart';
import 'package:overload/widgets/common/default_header.dart';
import 'package:overload/widgets/common/toggle_row.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;
  bool useGestures = false;
  String _selectedLanguage = 'en';

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('darkmode') ?? false;
      _selectedLanguage = prefs.getString('locale') ?? 'en';
    });
  }

  void _changeLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('locale', languageCode);
    setState(() {
      _selectedLanguage = languageCode;
    });
    MainApp.of(context).setLocale(languageCode);
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
                    AppLocalizations.of(context)!.settings,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: heightBetween),
                  ToggleSetting(
                    text: AppLocalizations.of(context)!.darkMode,
                    isToggled: isDarkMode,
                    changeValue: toggleDarkMode,
                  ),
                  const SizedBox(height: heightBetween),
                  ToggleSetting(
                    text: AppLocalizations.of(context)!.toggleGestures,
                    isToggled: useGestures,
                    changeValue: toggleGestures,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        "assets/img/shake_gesture.gif",
                        fit: BoxFit.contain,
                        gaplessPlayback: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: heightBetween),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.selectedLanguage,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        DropdownButton<String>(
                          value: _selectedLanguage,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              _changeLanguage(newValue);
                            }
                          },
                          items: <String>['en', 'nl']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value == 'en'
                                  ? 'English (EN)'
                                  : 'Dutch (NL)'),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: heightBetween),
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
      isDarkMode = value;
    });
    print(prefs.getBool('darkmode'));
    isDarkMode
        ? MainApp.of(context).changeTheme(ThemeMode.dark)
        : MainApp.of(context).changeTheme(ThemeMode.light);
  }
}
