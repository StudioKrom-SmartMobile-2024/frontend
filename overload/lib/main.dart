import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:overload/models/experience_intro_params.dart';
import 'package:overload/models/experience_params.dart';
import 'package:overload/pages/experience_rating.dart';
import 'package:overload/pages/settings.dart';
import 'package:overload/pages/videoplayer.dart';
import 'package:overload/pages/experience_intro.dart';
import 'package:overload/pages/welcome.dart';
import 'package:overload/pages/home.dart';
import 'package:overload/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  var isDarkMode = prefs.getBool('darkmode') ?? false;
  var locale = prefs.getString('locale') ?? 'en';
  ThemeMode initialThemeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
  runApp(MainApp(
    initialThemeMode: initialThemeMode,
    localeCode: locale,
  ));
}

class MainApp extends StatefulWidget {
  final ThemeMode initialThemeMode;
  final String localeCode;

  MainApp(
      {super.key, required this.initialThemeMode, required this.localeCode});

  @override
  State<MainApp> createState() => _MainAppState();

  static _MainAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MainAppState>()!;
}

class _MainAppState extends State<MainApp> {
  late String _localeCode;
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.initialThemeMode;
    _localeCode = widget.localeCode;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    return MaterialApp.router(
      locale: Locale(_localeCode),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeMode,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: const [
        Locale('en', ''),
        Locale('nl', ''),
      ],
    );
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  void setLocale(String localeCode) {
    setState(() {
      _localeCode = localeCode;
    });
  }

  final GoRouter _router = GoRouter(observers: [
    MyNavigatorObserver(),
  ], routes: <RouteBase>[
    GoRoute(
      path: WELCOME_ROUTE,
      builder: (BuildContext context, GoRouterState state) {
        return const WelcomePage();
      },
    ),
    GoRoute(
      path: EXPERIENCE_ROUTE,
      builder: (BuildContext context, GoRouterState state) {
        ExperienceParams params = state.extra as ExperienceParams;
        return VideoPlayerPage(
          params: params,
        );
      },
    ),
    GoRoute(
      path: SETTINGS_ROUTE,
      builder: (BuildContext context, GoRouterState state) {
        return SettingsPage();
      },
    ),
    GoRoute(
        path: RATE_ROUTE,
        builder: (BuildContext context, GoRouterState state) {
          return RateExperience();
        }),
    GoRoute(
      path: HOME_ROUTE,
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: INTRO_EXPERIENCE_BASE_ROUTE,
      builder: (BuildContext context, GoRouterState state) {
        final experienceName = state.pathParameters['experienceName'];
        switch (experienceName) {
          case "mall":
            return ExperienceIntro(
                params: ExperienceIntroParameters(
              url: '',
              indicators: {
                AppLocalizations.of(context)!.triggerCrowds: Icons.people,
                AppLocalizations.of(context)!.triggerNoise: Icons.volume_up,
              },
              title: AppLocalizations.of(context)!.theMallTitle,
              description: AppLocalizations.of(context)!.theMallDescriptionLong,
              strategies: {
                AppLocalizations.of(context)!.strategyHeadphones:
                    Icons.headphones,
                AppLocalizations.of(context)!.strategyFriends: Icons.group,
                AppLocalizations.of(context)!.strategyFamily: Icons.group
              },
              color: const Color(0xffFF2F26),
            ));
          case "station":
            return ExperienceIntro(
                params: ExperienceIntroParameters(
                    url: 'https://i.imgur.com/3WJFkSt.mp4',
                    indicators: {
                      AppLocalizations.of(context)!.triggerVehicles:
                          Icons.train,
                      AppLocalizations.of(context)!.triggerCrowds: Icons.people,
                      AppLocalizations.of(context)!.triggerNoise:
                          Icons.volume_up,
                    },
                    title: AppLocalizations.of(context)!.theStationTitle,
                    description:
                        AppLocalizations.of(context)!.theStationDescriptionLong,
                    strategies: {
                      AppLocalizations.of(context)!.strategyHeadphones:
                          Icons.headphones,
                      AppLocalizations.of(context)!.strategyFriends:
                          Icons.group,
                    },
                    color: const Color(0xffFEAC01)));
          case "playground":
            return ExperienceIntro(
                params: ExperienceIntroParameters(
                    url: '',
                    indicators: {
                      AppLocalizations.of(context)!.triggerKids:
                          Icons.family_restroom,
                      AppLocalizations.of(context)!.triggerCrowds: Icons.people,
                      AppLocalizations.of(context)!.triggerScreaming:
                          Icons.campaign,
                    },
                    title: AppLocalizations.of(context)!.thePlaygroundTitle,
                    description: AppLocalizations.of(context)!
                        .thePlaygroundDescriptionLong,
                    strategies: {
                      AppLocalizations.of(context)!.strategyAvoidKids:
                          Icons.route,
                      AppLocalizations.of(context)!.strategyHeadphones:
                          Icons.headset,
                    },
                    color: const Color(0xffC3F3B3)));

          case "concert":
            return ExperienceIntro(
                params: ExperienceIntroParameters(
                    url: '',
                    indicators: {
                      AppLocalizations.of(context)!.triggerLoud:
                          Icons.volume_up,
                      AppLocalizations.of(context)!.triggerCrowds: Icons.people,
                      AppLocalizations.of(context)!.triggerLights:
                          Icons.lightbulb,
                    },
                    title: AppLocalizations.of(context)!.theConcertTitle,
                    description:
                        AppLocalizations.of(context)!.theConcertDescriptionLong,
                    strategies: {
                      AppLocalizations.of(context)!.strategyEarplugs:
                          Icons.headphones,
                      AppLocalizations.of(context)!.strategyFriends:
                          Icons.group,
                    },
                    color: const Color(0xff07BFEB)));

          default:
            return const Placeholder();
        }
      },
    ),
  ]);
}

class MyNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('Pushed: $route, previous: $previousRoute');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('popped: $route, previous: $previousRoute');
  }
}
