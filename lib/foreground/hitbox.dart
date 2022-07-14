import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ps/dialogue_provider.dart';
import 'package:ps/res/res.dart';

class HitBox extends StatelessWidget {
  final Size cts;
  final AnimationController controller;
  const HitBox({Key? key, required this.cts, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double ratio = Dimens.sceneWidth/Dimens.sceneHeight;
    double top = cts.height;
    double widthS = cts.width;
    double heightS = widthS / ratio;
    double left = widthS/3.2;

    if(cts.width < Dimens.mobileView){
      widthS = cts.width * 2;
      heightS = widthS / ratio;
      left = widthS/6.9;
    }

    double w = widthS/19;
    double h = heightS/3.9;

    return PositionedTransition(
      rect: RelativeRectTween(
        begin: RelativeRect.fromSize(
            Rect.fromLTWH(left, top + heightS/3, w, h), cts),
        end: RelativeRect.fromSize(
            Rect.fromLTWH(left, top - heightS/1.5, w, h), cts),
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut)),
      child: FittedBox(child: GestureDetector(
        onTap: (){
          // context.read<DialogueProvider>().toggleInputVisibility();
          context.read<DialogueProvider>().talk();
        },
        child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(color: Color(0x00ffffff), width: w, height: h,)),
      ), fit: BoxFit.fill,),
    );
  }
}

