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

//Define constant icon sizes
const DEFAULT_ICON_SIZE = 34.00;
