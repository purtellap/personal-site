import 'package:flutter/material.dart';

/// Route management
class Routes {
  static String home = '/';
  static String portfolio = '/portfolio';

  /// Navigation
  static void go(BuildContext context, String route) {
    try {
      final current = ModalRoute.of(context);
      if (current != null) {
        Navigator.of(context).removeRouteBelow(current);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    Navigator.pushNamed(context, route);
  }
}
