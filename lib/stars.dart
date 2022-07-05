import 'package:flutter/material.dart';
import 'dart:math';

class Star extends StatelessWidget {
  final double size;
  final double y;
  final Size cts;
  final AnimationController controller;
  final Color color;
  const Star({Key? key, required this.size, required this.cts, required this.controller, required this.y, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double range = 0;
    return PositionedTransition(
        rect: RelativeRectTween(
          begin: RelativeRect.fromSize(
              Rect.fromLTWH(y, cts.height + range, size, size), cts),
          end: RelativeRect.fromSize(
              Rect.fromLTWH(y, -range, size, size), cts),
        ).animate(controller),
        child: DecoratedBox(decoration: BoxDecoration(color: color),)
    );
  }
}

class Stars extends StatelessWidget {
  final Size cts;
  final List<AnimationController> controllers;
  final List<double> ys;
  final List<Color> colors;
  const Stars({Key? key, required this.cts, required this.controllers, required this.ys, required this.colors}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var stars = <Widget>[];

    for (var i = 0; i < controllers.length; i++) {
      stars.add(Star(size: 3, cts: cts, controller: controllers[i], y: ys[i], color: colors[i],),);
    }

    return Stack(children: stars,);
  }
}

