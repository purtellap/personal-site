import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ps/dialogue_provider.dart';
import 'package:ps/res/res.dart';
import 'package:ps/util/typing_text.dart';
import 'dart:ui' as ui;

class InputDialogue extends StatelessWidget {
  final Size cts;
  final AnimationController controller;
  const InputDialogue({Key? key, required this.cts, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthS = cts.width;
    double left = widthS/3;

    double w = widthS;
    double h = 64;

    double top = cts.height - ((cts.width/(Dimens.sceneWidth/Dimens.sceneHeight))/1.5); // regular
    if(cts.width < Dimens.mobileView){
      top = cts.height - ((cts.width * 2/(Dimens.sceneWidth/Dimens.sceneHeight))/1.5);
    }

    double fontSize = min(12 + w/200, 30);

    DialogueProvider p = context.read<DialogueProvider>();
    double inputW = fontSize * 8;

    return PositionedTransition(
      rect: RelativeRectTween(
        begin: RelativeRect.fromSize(
            Rect.fromLTWH(0, cts.height + h, w, h), cts),
        end: RelativeRect.fromSize(
            Rect.fromLTWH(0, top - h, w, h), cts),
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut)),
      child: FittedBox(
        fit: BoxFit.fill,
        child: Container(color: Color(0x00000000), width: w, height: h,
          child: IgnorePointer(
            ignoring: !p.getIsInputVisible(),
            child: AnimatedOpacity(
              opacity: p.getIsInputVisible() ? 1.0 : 0.0,
              duration: Duration(milliseconds: p.getIsInputVisible() ? 500 : 100),
              child: Row(
                children: [
                  SizedBox(width: left - inputW/2,),
                  Container(
                    width: inputW,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OptionButton(fontSize: fontSize, s: Strings.talk,
                          onTap: (){
                            p.talk();
                          },
                        ),
                        OptionButton(fontSize: fontSize, s: Strings.ask,
                          onTap: (){

                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OptionButton extends StatefulWidget {
  const OptionButton({Key? key, required this.fontSize, required this.s, required this.onTap}) : super(key: key);
  final double fontSize;
  final String s;
  final Function()? onTap;

  @override
  State<OptionButton> createState() => _OptionButtonState();
}

class _OptionButtonState extends State<OptionButton> {

  bool isHover = false;

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = TextStyle(color: Colors.white, fontSize: widget.fontSize,
        fontFamily: 'retro', letterSpacing: .8, fontWeight: FontWeight.w100);
    TextStyle textStyleHover = TextStyle(color: Colors.black, fontSize: widget.fontSize,
        fontFamily: 'retro', letterSpacing: .8, fontWeight: FontWeight.w100);

    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (e){
            setState(() {
              isHover = true;
            });
          },
          onExit: (e){
            setState(() {
              isHover = false;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            //child: Text(widget.s, style: isHover ? textStyleHover : textStyle),
            child: AnimatedDefaultTextStyle(style: isHover ? textStyleHover : textStyle, duration: Duration(milliseconds: 200), child: Text(widget.s),),
          )
      ),
    );
  }
}
