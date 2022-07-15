import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ps/dialogue_provider.dart';
import 'package:ps/res/res.dart';
import 'package:ps/util/typing_text.dart';
import 'dart:ui' as ui;

class TalkDialogue extends StatelessWidget {
  final Size cts;
  final AnimationController controller;
  const TalkDialogue({Key? key, required this.cts, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthS = cts.width;
    double left = widthS/2.75;
    double ratio = Dimens.sceneWidth/Dimens.sceneHeight;

    double w = widthS;
    double h = 144;

    double top = cts.height - ((cts.width/ratio)/1.5); // regular
    if(cts.width < Dimens.mobileView){
      top = cts.height - ((cts.width * 2/ratio)/1.5);
      if(cts.width < Dimens.mobileView2){
        top = cts.height - ((cts.width * 3/ratio)/1.5);
        left = widthS/2;
        if(cts.height < Dimens.mobileLandscape){
          top = cts.height - ((cts.width * 3/ratio)/2.5);
        }
      }
      else if(cts.height < Dimens.mobileLandscape){
        top = cts.height - ((cts.width * 2/ratio)/2.5);
      }
    }

    double fontSize = min(12 + w/200, 30);

    DialogueProvider p = context.read<DialogueProvider>();
    Widget dialogueText = p.fixedAnim ? new TypingText(s: p.getCurrentTalk(), fontSize: fontSize,) : SizedBox();

    Text boxText = Text(p.getCurrentTalk(), style: TextStyle(color: Colors.transparent, fontSize: fontSize,
        fontFamily: 'retro', letterSpacing: .8, fontWeight: FontWeight.w100 ));

    return PositionedTransition(
      rect: RelativeRectTween(
        begin: RelativeRect.fromSize(
            Rect.fromLTWH(0, cts.height + h, w, h), cts),
        end: RelativeRect.fromSize(
            Rect.fromLTWH(0, top - h, w, h), cts),
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut)),
      child: AnimatedOpacity(
        opacity: p.getIsTalkVisible() ? 1.0 : 0.0,
        duration: Duration(milliseconds: p.getIsTalkVisible() ? 0 : 500),
        onEnd: (){
          if(!p.getIsTalkVisible()){
            p.fixTween(false);
          }
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(width: left,),
                CustomPaint( //                       <-- CustomPaint widget
                  size: Size(20, 20),
                  painter: SpeechBubble(),
                ),
                SizedBox(width: left/2,),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(width: left,),
                DialogueBox(color: Colors.white,
                  child: Stack(
                    children: [
                      p.fixedAnim ? boxText : SizedBox(),
                      p.fixedAnim ? dialogueText : SizedBox()
                    ],
                  )
                ),
                SizedBox(width: cts.width < Dimens.mobileView2 ? 16 : left/2,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DialogueBox extends StatelessWidget {
  const DialogueBox({Key? key, required this.child, required this.color}) : super(key: key);
  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.all(Radius.circular(24))),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: child,
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
