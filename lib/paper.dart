import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ps/res/resources.dart';
import 'package:ps/url.dart';

class Paper extends StatelessWidget {
  final Size cts;
  final AnimationController controller;
  final Image img;
  const Paper({Key? key, required this.cts, required this.controller, required this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double ratio = Dimens.sceneWidth/Dimens.sceneHeight;
    double top = cts.height;
    double widthS = cts.width;
    double heightS = widthS / ratio;
    double size = widthS/32;
    return PositionedTransition(
      rect: RelativeRectTween(
        begin: RelativeRect.fromSize(
            Rect.fromLTWH(0, top, size, size), cts),
        end: RelativeRect.fromSize(
            Rect.fromLTWH(widthS/14, top-heightS/1.8, size, size), cts),
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut)),
      child: FittedBox(child: GestureDetector(
        onTap: (){
          LaunchURL.of(Strings.resumeLink);
        },
        child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: img),
      ), fit: BoxFit.fill,),
    );
  }
}

