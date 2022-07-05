import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchURL {

  static of(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}