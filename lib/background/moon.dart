import 'package:flutter/material.dart';
import 'package:ps/res/res.dart';


class Moon extends StatelessWidget {
  final Size cts;
  final AnimationController controller;
  final Image img;
  final double mobileOffset;
  const Moon({Key? key, required this.cts, required this.controller,
    required this.img, required this.mobileOffset}) : super(key: key);

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
      left = -width/mobileOffset;
      if(cts.width < Dimens.mobileView2){
        width = cts.width * 3;
        height = width / ratio;
        left = -width/mobileOffset * 1.3;
      }
      if(cts.height < Dimens.mobileLandscape){
        top = cts.height + height/2;
      }
    }

    return PositionedTransition(
      rect: RelativeRectTween(
        begin: RelativeRect.fromSize(
            Rect.fromLTWH(left, -height/3, width, height), cts),
        end: RelativeRect.fromSize(
            Rect.fromLTWH(left, top-height*1.2, width, height), cts),
      ).animate(CurvedAnimation(parent: controller, curve: Curves.linear)),
      child: FittedBox(child: img, fit: BoxFit.fill,),
    );
  }
}