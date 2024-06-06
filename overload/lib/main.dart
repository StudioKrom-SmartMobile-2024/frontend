import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:overload/models/experience_intro_params.dart';
import 'package:overload/models/experience_params.dart';
import 'package:overload/pages/settings.dart';
import 'package:overload/pages/videoplayer.dart';
import 'package:overload/pages/experience_intro.dart';
import 'package:overload/pages/welcome.dart';
import 'package:overload/pages/home.dart';
import 'package:overload/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  var isDarkMode = prefs.getBool('darkmode') ?? false;
  ThemeMode initialThemeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
  runApp(MainApp(initialThemeMode: initialThemeMode));
}

class MainApp extends StatefulWidget {
  final ThemeMode initialThemeMode;

  MainApp({super.key, required this.initialThemeMode});

  @override
  State<MainApp> createState() => _MainAppState();

  static _MainAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MainAppState>()!;
}

class _MainAppState extends State<MainApp> {
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.initialThemeMode;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeMode,
    );
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
    print("Theme set to $themeMode");
  }

  final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const WelcomePage();
        },
      ),
      GoRoute(
        path: '/experience',
        builder: (BuildContext context, GoRouterState state) {
          ExperienceParams params = state.extra as ExperienceParams;
          return VideoPlayerPage(
            params: params,
          );
        },
      ),
      GoRoute(
          path: '/home',
          builder: (BuildContext context, GoRouterState state) {
            return const HomePage();
          },
          routes: [
            GoRoute(
              path: 'settings',
              builder: (BuildContext context, GoRouterState state) {
                return SettingsPage();
              },
            ),
            GoRoute(
              path: 'intro/:experienceName',
              builder: (BuildContext context, GoRouterState state) {
                final experienceName = state.pathParameters['experienceName'];
                switch (experienceName) {
                  case "mall":
                    return ExperienceIntro(
                        params: ExperienceIntroParameters(
                      url: '',
                      indicators: {
                        "Crowds": Icons.people,
                        "Noise": Icons.volume_up,
                      },
                      title: 'The Mall',
                      description:
                          'Enter a lively shopping center filled with colorful advertisements, loud chatter, and diverse store sounds. Experience the sensory overload of a day spent at the mall.',
                      strategies: {
                        "Wear headphones": Icons.headphones,
                        "Go with friends": Icons.group,
                        "Go with family": Icons.group
                      },
                      color: const Color(0xffFF2F26),
                    ));
                  case "station":
                    return ExperienceIntro(
                        params: ExperienceIntroParameters(
                            url: 'https://i.imgur.com/3WJFkSt.mp4',
                            indicators: {
                              "Vehicles": Icons.train,
                              "Crowds": Icons.people,
                              "Noise": Icons.volume_up,
                            },
                            title: 'Train station',
                            description:
                                'Step into a bustling train station filled with the hustle and bustle of commuters rushing to catch their rides. The sound of trains arriving and departing, the PA system announcing arrivals and delays, and the chatter of passengers creates a symphony of noise. The smell of coffee, food vendors, and exhaust fumes fills the air as people weave in and out of the crowds.',
                            strategies: {
                              "Wear headphones": Icons.headphones,
                              "Go with friends": Icons.group,
                            },
                            color: const Color(0xffFEAC01)));
                  case "playground":
                    return ExperienceIntro(
                        params: ExperienceIntroParameters(
                            url: '',
                            indicators: {
                              "Kids": Icons.family_restroom,
                              "Crowds": Icons.people,
                              "Screaming": Icons.campaign,
                            },
                            title: 'At the playground',
                            description:
                                'Enter a lively playground filled with the laughter of children running and playing. The sounds of squeaking swings, clanging metal bars, and playful shouts create an atmosphere of joy and energy. The smell of freshly cut grass, sunscreen, and snacks drifts through the air as parents watch over their kids and the sound of giggles and slides fills the air.',
                            strategies: {
                              "Avoid kids": Icons.route,
                              "Wear headset": Icons.headset,
                            },
                            color: const Color(0xffC3F3B3)));

                  case "concert":
                    return ExperienceIntro(
                        params: ExperienceIntroParameters(
                            url: '',
                            indicators: {
                              "Loud": Icons.volume_up,
                              "Crowds": Icons.people,
                              "Lights": Icons.lightbulb,
                            },
                            title: 'At a concert',
                            description:
                                'Feel the energy of a packed concert venue as the music fills the air and the crowd roars with excitement. The thumping bass, screaming fans, and vibrant lights create a sensory overload of sound and sight. The smell of sweat, beer, and popcorn mingles with the excitement as the performers take the stage and the music starts to play.',
                            strategies: {
                              "Earplugs": Icons.headphones,
                              "Go with friends": Icons.group,
                            },
                            color: const Color(0xff07BFEB)));

                  default:
                    return const Placeholder();
                }
              },
            ),
          ]),
    ],
  );
}
