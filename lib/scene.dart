import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ps/res/resources.dart';


class Scene extends StatelessWidget {
  final Size cts;
  final AnimationController controller;
  final Image img;
  const Scene({Key? key, required this.cts, required this.controller, required this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double ratio = Dimens.sceneWidth/Dimens.sceneHeight;
    double top = cts.height;
    double width = cts.width;
    double height = width / ratio;
    return PositionedTransition(
      rect: RelativeRectTween(
        begin: RelativeRect.fromSize(
            Rect.fromLTWH(0, top, width, height), cts),
        end: RelativeRect.fromSize(
            Rect.fromLTWH(0, top-height, width, height), cts),
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut)),
      child: FittedBox(child: img, fit: BoxFit.fill,),
    );
  }
}

