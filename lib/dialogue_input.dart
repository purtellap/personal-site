import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ps/audio/audio_provider.dart';
import 'package:ps/dialogue_provider.dart';
import 'package:ps/res/res.dart';

class InputDialogue extends StatelessWidget {
  final Size cts;
  const InputDialogue({Key? key, required this.cts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthS = cts.width;

    double w = widthS;

    double fontSize = min(12 + w/200, 30);

    DialogueProvider p = context.read<DialogueProvider>();
    double inputW = fontSize * 16;
    double inputH = fontSize * 3;

    return AnimatedPositioned(
      top: !p.getIsInputVisible() ? cts.height: cts.height - inputH,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
      child: Container(color:  (p.getIsInputVisible() || p.isInputAnimOver) ? Color(0xaa000000) : Colors.transparent, width: w, height: inputH,
        child: IgnorePointer(
          ignoring: !p.getIsInputVisible(),
          child: AnimatedOpacity(
            opacity: p.getIsInputVisible() ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                          p.ask();
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
    );
  }
}

class QuestionDialogue extends StatelessWidget {
  final Size cts;
  const QuestionDialogue({Key? key, required this.cts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthS = cts.width;

    double w = widthS;

    double fontSize = min(12 + w/200, 30);

    DialogueProvider p = context.read<DialogueProvider>();
    AudioProvider a = context.read<AudioProvider>();
    double inputW = fontSize * 32;
    double inputH = fontSize * 3;

    List<OptionButton> questions = [];
    for (int i = 0; i < Strings.questions.length; i++){
      questions.add(
        OptionButton(fontSize: fontSize, s: Strings.questions[i],
          onTap: (){
            p.answer(Strings.answers[i]);
          }
        )
      );
    }

    return AnimatedPositioned(
      top: !p.getIsQuestionVisible() ? cts.height: cts.height - inputH,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
      child: Container(color:  (p.getIsQuestionVisible() || p.isQuestionAnimOver) ? Color(0xaa000000) : Colors.transparent, width: w, height: inputH,
        child: IgnorePointer(
          ignoring: !p.getIsQuestionVisible(),
          child: AnimatedOpacity(
            opacity: p.getIsQuestionVisible() ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: inputW,
                  child: Row(
                    mainAxisAlignment: inputW < 500 ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
                    children: questions,
                  ),
                ),
              ],
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
    TextStyle textStyleHover = TextStyle(color: Color(0xff00ffff), fontSize: widget.fontSize,
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
