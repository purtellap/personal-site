import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ps/res/res.dart';


class Scene extends StatelessWidget {
  final Size cts;
  final AnimationController controller;
  final Image img;
  final double offset;
  const Scene({Key? key, required this.cts, required this.controller, required this.img, required this.offset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double ratio = Dimens.sceneWidth/Dimens.sceneHeight;
    double top = cts.height;
    double width = cts.width;
    double height = width / ratio;
    double left = 0;

    if(cts.width < Dimens.mobileView){
      width = cts.width * 2;
      height = width / ratio;
      left = -width/offset;
    }

    return PositionedTransition(
      rect: RelativeRectTween(
        begin: RelativeRect.fromSize(
            Rect.fromLTWH(left, top, width, height), cts),
        end: RelativeRect.fromSize(
            Rect.fromLTWH(left, top-height, width, height), cts),
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut)),
      child: FittedBox(child: img, fit: BoxFit.fill,),
    );
  }
}

