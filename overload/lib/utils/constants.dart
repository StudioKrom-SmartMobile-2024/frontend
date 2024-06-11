// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

//Define the constant colors referenced in the app.
const COLOR_RED = Color(0xFFFF2F26);
const COLOR_ORANGE = Color(0XFFFEAC01);
const COLOR_GREEN = Color(0xFFC3F3B3);
const COLOR_BLUE = Color(0xFF07BFEB);
const COLOR_BLACK = Color(0xFF000000);
const COLOR_NAVY = Color(0xFF031A2A);
const COLOR_WHITE = Color(0xFFFFFFFF);
const COLOR_GRAY = Color(0x99D9D9D9);
const COLOR_ALMOSTBLACK = Color.fromARGB(255, 36, 36, 36);
const COLOR_DARK_GRAY = Color(0xD9484848);

//Define font sizes
const TITLE_FONTSIZE = 38.00;
const HEADER_FONTSIZE = 34.00;
const SUBHEADER_FONTSIZE = 21.00;
const BODY_FONTSIZE = 14.00;
const DETAILS_FONTSIZE = 11.00;

//Define font families
const FONT_GULF = "Gulf";
const FONT_ROBOTO = "Roboto";

//Define default text styles
const TITLE_TEXT_STYLE = TextStyle(
    fontSize: TITLE_FONTSIZE, color: COLOR_BLACK, fontFamily: FONT_GULF);

const HEADER_TEXT_STYLE = TextStyle(
    fontSize: HEADER_FONTSIZE, color: COLOR_BLACK, fontFamily: FONT_GULF);

const SUBHEADER_TEXT_STYLE = TextStyle(
  fontSize: SUBHEADER_FONTSIZE,
  color: COLOR_NAVY,
  fontFamily: FONT_GULF,
);

const BODY_TEXT_STYLE = TextStyle(
    fontSize: BODY_FONTSIZE,
    color: COLOR_BLACK,
    fontFamily: FONT_ROBOTO,
    fontWeight: FontWeight.w500);

const DETAILS_TEXT_STYLE = TextStyle(
    fontSize: DETAILS_FONTSIZE,
    color: COLOR_BLACK,
    fontFamily: FONT_ROBOTO,
    fontWeight: FontWeight.w400);

//Define the default gradient of the 'Overload' app
const OVERLOAD_GRADIENT = LinearGradient(
  colors: [
    Color(0xFFFF6D74),
    Color(0xFFFF9048),
  ],
);

const DISABLED_OVERLOAD_GRADIENT = LinearGradient(
  colors: [
    Color.fromARGB(130, 255, 109, 116),
    Color.fromARGB(130, 255, 145, 72),
  ],
);

const OVERLOAD_GRADIENT_LOW = LinearGradient(
  colors: [
    Color.fromRGBO(188, 241, 182, 1),
    Color.fromRGBO(49, 203, 223, 1),
  ],
);

const OVERLOAD_GRADIENT_MEDIUM = LinearGradient(
  colors: [
    Color.fromRGBO(252, 204, 0, 1),
    Color.fromRGBO(255, 108, 25, 1),
  ],
);

const OVERLOAD_GRADIENT_HIGH = LinearGradient(
  colors: [
    Color.fromRGBO(255, 146, 85, 1),
    Color.fromRGBO(255, 47, 49, 1),
  ],
);

//Define constant icon sizes
const DEFAULT_ICON_SIZE = 34.00;

// Light theme definition
final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: COLOR_WHITE,
    onPrimary: COLOR_BLACK,
    secondary: COLOR_GRAY,
    onSecondary: COLOR_BLACK,
    surface: COLOR_WHITE,
    error: COLOR_RED,
    onError: COLOR_BLACK,
    onSurface: COLOR_BLACK,
    // Add other properties if needed
  ),
  textTheme: const TextTheme(
    titleLarge: TITLE_TEXT_STYLE,
    headlineLarge: HEADER_TEXT_STYLE,
    headlineMedium: SUBHEADER_TEXT_STYLE,
    bodyLarge: BODY_TEXT_STYLE,
    bodyMedium: DETAILS_TEXT_STYLE,
  ),
);

// Dark theme definition
final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: COLOR_ALMOSTBLACK,
    onPrimary: COLOR_WHITE,
    secondary: COLOR_DARK_GRAY,
    onSecondary: COLOR_WHITE,
    surface: COLOR_ALMOSTBLACK,
    error: COLOR_RED,
    onError: COLOR_WHITE,
    onSurface: COLOR_WHITE,
    // Add other properties if needed
  ),
  textTheme: TextTheme(
    titleLarge: TITLE_TEXT_STYLE.copyWith(color: COLOR_WHITE),
    headlineLarge: HEADER_TEXT_STYLE.copyWith(color: COLOR_WHITE),
    headlineMedium: SUBHEADER_TEXT_STYLE.copyWith(color: COLOR_WHITE),
    bodyLarge: BODY_TEXT_STYLE.copyWith(color: COLOR_WHITE),
    bodyMedium: DETAILS_TEXT_STYLE.copyWith(color: COLOR_WHITE),
  ),
);

//Define the routes
const WELCOME_ROUTE = "/";
const HOME_ROUTE = "/home";
const RATE_ROUTE = "/rate";
const SETTINGS_ROUTE = "/settings";
const EXPERIENCE_ROUTE = "/experience";
const INTRO_EXPERIENCE_BASE_ROUTE = "/intro/:experienceName";
const INTRO_EXPERIENCE_MALL_ROUTE = "/intro/mall";
const INTRO_EXPERIENCE_STATION_ROUTE = "/intro/station";
const INTRO_EXPERIENCE_CONCERT_ROUTE = "/intro/stage";
const INTRO_EXPERIENCE_PLAYGROUND_ROUTE = "/intro/playground";
