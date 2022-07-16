import 'package:flutter/material.dart';

import '../res/res.dart';

class Sunset extends StatelessWidget {
  final Size cts;
  final AnimationController controller;
  final Image img;
  final double mobileOffset;
  final bool sunset;
  const Sunset({Key? key, required this.cts, required this.controller,
    required this.img, required this.mobileOffset, required this.sunset}) : super(key: key);

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
        left = -width/mobileOffset * 1.1;
      }
      if(cts.height < Dimens.mobileLandscape){
        top = cts.height + height/4.2;
      }
    }
    return TweenAnimationBuilder<int>(
        tween: IntTween(begin: 0, end: 1000),
        duration: Duration(seconds: (Dimens.sunsetDuration * 10).toInt()),
        builder: (context, int i, child) {
          return Positioned(
            left: left,
            top: top - height + i,
            width: width,
            height: height,
            child: TweenAnimationBuilder<Color?>(
              tween: ColorTween(begin: Color(0xfffdebb9), end: Color(0xfff53527)),
              curve: Curves.easeOut,
              duration: Duration(seconds: (Dimens.sunsetDuration * 1.4).toInt()),
              builder: (context, Color? color, child) {
                return FittedBox(child: sunset ?
                ColorFiltered(colorFilter:
                ColorFilter.mode(color ?? Colors.transparent, BlendMode.srcATop, ),
                    child: img) : img );
              },
            ),
          );
      }
    );
  }
}