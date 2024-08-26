import 'package:flutter/material.dart';

// theme default values
const String kBaseFontFamily = 'Poppins';

// Colors
const Color cTransparent = Colors.transparent;
const Color cWhite = Colors.white;
const Color cBlack = Colors.black87;
const Color cGrey = Colors.grey;
const Color cLightYellow = Color.fromRGBO(255, 245, 157, 1);
const Color cOrange = Colors.orange;
const Color cLightGreen = Colors.lightGreen;
const Color cGreen = Colors.green;
const Color cLightRed = Color.fromRGBO(255, 205, 210, 1);
const Color cRed = Colors.red;
const Color cTeal = Colors.teal;
const Color cLightBlue = Color.fromARGB(255, 189, 225, 255);
const Color cBlue = Colors.blue;
const Color cDeepBlue = Color.fromRGBO(13, 71, 161, 1);
const Color cDarkBlue = Color.fromRGBO(38, 53, 93, 1);

// Typography
const double fHeadline1 = 32.0;
const double fHeadline2 = 24.0;
const double fHeadline3 = 20.0;
const double fParagraph = 16.0;
const double fLabel = 14.0;
const double fSmall = 12.0;

// Fontweight
const FontWeight fLight = FontWeight.w300;
const FontWeight fMedium = FontWeight.w400;
const FontWeight fBold = FontWeight.w700;

// FontStyle
const FontStyle fItalic = FontStyle.italic;

/// RumahKitaTheme
class RumahKitaTheme {
  static ThemeData get light {
    return ThemeData(
      fontFamily: kBaseFontFamily,
      colorScheme: ColorScheme.fromSeed(
        seedColor: cTeal,
      ),
    );
  }
}
