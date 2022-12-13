import 'package:flutter/material.dart';

class Dimens {
  static const int borderRadius = 16;
  static const double splashRadius = 24;
  static const int sceneHeight = 512;
  static const int sceneWidth = 1536;
  static const int mobileView = 900;
  static const int mobileView2 = 600;
  static const int mobileLandscape = 420;

  static const int sunsetDuration = 80;

  static const int gradientDuration = 3; // 5
  static const int openingGradientsNum = 6;
  static const int totalGradientDuration =
      gradientDuration * openingGradientsNum;
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
  static const String title = 'Austin\'s Site';
  static const String resumeLink =
      'https://drive.google.com/file/d/1Jlgmg_8CfhOHr--oCupWvxPYTot_T3Yl/view?usp=share_link';

  // Dialogue
  static const String talk = '[ talk ]';
  static const String ask = '[ ask ]';

  static const String end1 = 'You\'re very patient.';
  static const String end2 = 'Thanks for checking out my website.';

  static List<String> talks = [
    'Hello.',
    'Ah, to be free...',
    '\"Be a philosopher; but, amidst all your philosophy, be still a man.\"',
    'I trade crypto as a hobby.',
    'One day I want to live on a boat.',
    'Don\'t take life so seriously.',
    'I was a collegiate level rocket league player for a time.',
    'Almost there...',
    'It\'s peaceful out here.',
    'Good skimboarding down there...',
    'Whitewater rafting is an intense summer job.',
  ]..shuffle();

  static const List<String> questions = [
    'Like to do?',
    'Interests?',
    'Life Goals?',
  ];

  static const List<String> answers = [
    'I like to learn and experience new things.',
    'Outdoors, Crypto, Astronomy, Gaming, Youtube...',
    'Explore the world, help the environment, have fun.',
  ];
}

class Images {
  static const Image ocean = Image(
      image: AssetImage('assets/images/ocean.gif'),
      filterQuality: FilterQuality.none,
      isAntiAlias: false);
  static const Image sun = Image(
      image: AssetImage('assets/images/sun.gif'),
      filterQuality: FilterQuality.none,
      isAntiAlias: false);
  static const Image cliff = Image(
      image: AssetImage('assets/images/cliff.gif'),
      filterQuality: FilterQuality.none,
      isAntiAlias: false);
  static const Image paper = Image(
      image: AssetImage('assets/images/paper.gif'),
      filterQuality: FilterQuality.none,
      isAntiAlias: false);
  static const Image moon = Image(
      image: AssetImage('assets/images/moon.gif'),
      filterQuality: FilterQuality.none,
      isAntiAlias: false);
}

class TextStyles {
  static const TextStyle dialog = TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontFamily: 'retro',
      letterSpacing: .8,
      fontWeight: FontWeight.w100);
}
