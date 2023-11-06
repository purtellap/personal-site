
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchURL {
  static Future<void> of(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint('Could not launch $url');
    }
  }
}
