import 'dart:convert';
import 'package:http/http.dart' as http;

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

class Email {
  static Future send(
      {required String name,
      required String email,
      required String message}) async {
    const serviceId = 'service_b8guw1a';
    const templateId = 'template_iu8qj8h';
    const userId = 'user_opMB4DYe8DAc4zLXXWcyp';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        // 'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'user_name': name,
            'user_email': email,
            'user_message': message,
            'to_email': 'Strings.contactEmail',
          }
        },
      ),
    );
  }
}
