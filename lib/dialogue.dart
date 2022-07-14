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
    double ratio = Dimens.sceneWidth/Dimens.sceneHeight;
    double top = cts.height;
    double widthS = cts.width;
    double heightS = widthS / ratio;
    double left = widthS/3.5;

    if(cts.width < Dimens.mobileView){
      widthS = cts.width * 2;
      heightS = widthS / ratio;
      left = widthS/6.9;
    }

    double w = widthS;
    double h = heightS/6;

    DialogueProvider p = context.read<DialogueProvider>();

    return PositionedTransition(
      rect: RelativeRectTween(
        begin: RelativeRect.fromSize(
            Rect.fromLTWH(0, top + heightS/3, w, h), cts),
        end: RelativeRect.fromSize(
            Rect.fromLTWH(0, top - heightS/1.2, w, h), cts),
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut)),
      child: FittedBox(
        fit: BoxFit.fill,
        child: Container(color: Color(0x33ff0000), width: w, height: h,
          child: AnimatedOpacity(
            opacity: p.getIsInputVisible() ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Row(
              children: [
                SizedBox(width: left,),
                MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(Strings.talk, style: TextStyles.dialog,),
                    )),
                SizedBox(width: 48,),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(Strings.ask, style: TextStyles.dialog),
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TalkDialogue extends StatelessWidget {
  final Size cts;
  final AnimationController controller;
  const TalkDialogue({Key? key, required this.cts, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthS = cts.width;
    double left = widthS/2.75;

    double w = widthS;
    double h = 148;

    double top = cts.height - ((cts.width/(Dimens.sceneWidth/Dimens.sceneHeight))/1.5); // regular
    if(cts.width < Dimens.mobileView){
      top = cts.height - ((cts.width * 2/(Dimens.sceneWidth/Dimens.sceneHeight))/1.5);
    }

    DialogueProvider p = context.read<DialogueProvider>();
    Widget dialogueText = p.fixedAnim ? new TypingText(s: p.getCurrentTalk(), fontSize: min(12 + w/200, 30),) : SizedBox();

    Container boxText = Container(child: Text(p.getCurrentTalk(), style: TextStyle(color: Colors.transparent, fontSize: min(12 + w/200, 30),
        fontFamily: 'retro', letterSpacing: .8, fontWeight: FontWeight.w100 )),);

    Widget dialogueBox = p.fixedAnim ? boxText : SizedBox();

    return PositionedTransition(
      rect: RelativeRectTween(
        begin: RelativeRect.fromSize(
            Rect.fromLTWH(0, cts.height + h, w, h), cts),
        end: RelativeRect.fromSize(
            Rect.fromLTWH(0, top - h, w, h), cts),
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut)),
      child: Container(color: Color(0x00ffffff), width: w,
        child: AnimatedOpacity(
          opacity: p.getIsTalkVisible() ? 1.0 : 0.0,
          duration: Duration(milliseconds: p.getIsTalkVisible() ? 0 : 500),
          onEnd: (){
            if(!p.getIsTalkVisible()){
              p.fixTween(false);
            }
          },
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(width: left, height: 128,),
                  CustomPaint( //                       <-- CustomPaint widget
                    size: Size(20, 20),
                    painter: SpeechBubble(),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(width: left,),
                  Flexible(
                    child: Container(
                      height: 128,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(24))),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: dialogueBox,
                      ),
                    ),
                  ),
                  SizedBox(width: left/2,),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(width: left,),
                  Flexible(
                    child: Container(
                      height: 128,
                      decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.all(Radius.circular(24))),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: dialogueText,
                      ),
                    ),
                  ),
                  SizedBox(width: left/2,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashedLine extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p1 = Offset(0, 10);
    final p2 = Offset(20, 0);
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2;
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}

class SpeechBubble extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 10
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;
    final pointMode = ui.PointMode.polygon;
    final points = [
      Offset(10, 0),
      Offset(0, 20),
      Offset(20, 15),
    ];
    canvas.drawPoints(pointMode, points, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}