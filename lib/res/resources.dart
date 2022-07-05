import 'package:flutter/material.dart';

class Keys {
  static const String THEME_PREF = 'themePref';
  static const String ACCENT_PREF = 'accentPref';
  static const String ACCOUNTS_PREF = 'accountsList';
}

class Dimens {
  static const int borderRadius = 16;
  static const double splashRadius = 24;
  static const int sceneHeight = 512;
  static const int sceneWidth = 1536;
}

class ThemeColors {

  // Dark Theme
  static const Color backgroundColorDark = Color(0xFF121212);
  static const Color overlayColorDark = Color(0x11ffffff);
  static const Color textColorDark = Colors.white;
  static const Color secondaryTextColorDark = Colors.grey;

  // Accent Colors
  static const Color winter = Color(0xffB3DAF1);
  static const Color underlineColor = Color(0x44000000);
  static const Color selectionColor = Color(0x66888888);
  static const Color linkColor = Color(0xaaaaaaaa);
}

class Strings {
  static const String title = 'Austin Purtell\'s Site';
  static const String resume = 'RESUME';
  static const String name = 'AUSTIN PURTELL';
}

class Images {
  static const Image ocean = Image(image: AssetImage('assets/images/ocean.gif'),  filterQuality: FilterQuality.none, isAntiAlias: false);
  static const Image sun = Image(image: AssetImage('assets/images/sun.gif'),  filterQuality: FilterQuality.none, isAntiAlias: false);
  static const Image cliff = Image(image: AssetImage('assets/images/cliffanim.gif'),  filterQuality: FilterQuality.none, isAntiAlias: false);
}