import 'dart:math';

import 'package:flutter/material.dart';

class Star extends StatelessWidget {
  final double size;
  final double x;
  final Size cts;
  final AnimationController controller;
  final Color color;
  const Star(
      {Key? key,
      required this.size,
      required this.cts,
      required this.controller,
      required this.x,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double range = 0;
    return PositionedTransition(
        rect: RelativeRectTween(
          begin: RelativeRect.fromSize(
              Rect.fromLTWH(x, cts.height + range, size, size), cts),
          end: RelativeRect.fromSize(Rect.fromLTWH(x, -range, size, size), cts),
        ).animate(controller),
        child: DecoratedBox(
          decoration: BoxDecoration(color: color),
        ));
  }
}

class Stars extends StatelessWidget {
  final Size cts;
  final List<AnimationController> controllers;
  final List<double> ys;
  final List<double> xs;
  final List<Color> colors;
  final bool sunset;
  const Stars(
      {Key? key,
      required this.cts,
      required this.controllers,
      required this.ys,
      required this.xs,
      required this.colors,
      required this.sunset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var stars = <Widget>[];

    for (var i = 0; i < controllers.length; i++) {
      var r = Random(i);
      double x = r.nextDouble() * (cts.width - 32) + 16;
      double y = r.nextDouble() * (cts.height - 32) + 16;
      if (!sunset) {
        stars.add(
          Star(
            size: 3,
            cts: cts,
            controller: controllers[i],
            x: x,
            color: colors[i],
          ),
        );
      } else {
        stars.add(
          Star2(
            size: 3,
            cts: cts,
            y: y,
            x: x,
            color: colors[i],
            controller: controllers[i],
          ),
        );
      }
    }
    return Stack(children: stars);
  }
}

class Star2 extends StatelessWidget {
  final double size;
  final double x;
  final double y;
  final Size cts;
  final AnimationController controller;
  final Color color;
  const Star2(
      {Key? key,
      required this.size,
      required this.cts,
      required this.controller,
      required this.x,
      required this.y,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PositionedTransition(
      rect: RelativeRectTween(
        begin: RelativeRect.fromSize(Rect.fromLTWH(x, y, size, size), cts),
        end: RelativeRect.fromSize(Rect.fromLTWH(x, y, size, size), cts),
      ).animate(controller),
      child: DecoratedBox(
        decoration: BoxDecoration(color: color),
      ),
    );
  }
}
