import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ps/audio/audio_provider.dart';

import '../dialogue_provider.dart';
import '../res/res.dart';

class TypingText extends StatelessWidget {
  const TypingText({Key? key, required this.s, required this.fontSize}) : super(key: key);
  final String s;
  final double fontSize;

  @override
  Widget build(BuildContext context) {

    AudioProvider a = context.read<AudioProvider>();
    DialogueProvider p = context.read<DialogueProvider>();

    return TweenAnimationBuilder<int>(
      onEnd: (){
        //a.stopTyping();
        Future.delayed(Duration(seconds: 2), (){
          p.toggleTalkVisibility();
        });
      },
      duration: Duration(seconds: 2 + s.length~/50),
      tween: IntTween(
          begin: 0, end: s.length),
      builder: (context, int value, child) {
        a.playTyping(value);
        return Text(s.substring(0, value), style: TextStyle(color: Colors.black, fontSize: fontSize,
            fontFamily: 'retro', letterSpacing: .8, fontWeight: FontWeight.w100 ));
      },
    );
  }
}