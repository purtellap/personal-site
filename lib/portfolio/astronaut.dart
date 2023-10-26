import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ps/res/res.dart';

class Astronaut extends StatefulWidget {
  @override
  _AstronautState createState() => _AstronautState();
}

class _AstronautState extends State<Astronaut>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final double size = 300;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return Transform.translate(
          offset: Offset(
            7 * cos(_controller.value * 2 * pi),
            5 * sin(_controller.value * 2 * pi),
          ),
          child: child,
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Image.asset(
          Images.astronaut,
          width: size,
          height: size,
        ),
      ),
    );
  }
}
