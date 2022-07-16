import 'package:flutter/material.dart';

import '../res/res.dart';

class AnimatedGradient extends StatefulWidget {
  @override
  _AnimatedGradientState createState() => _AnimatedGradientState();
}

class _AnimatedGradientState extends State<AnimatedGradient> {
  final List<Color> colors = [
    Colors.black,
    Colors.black,
    Color(0xff070b34),
    Color(0xff141852),
    Color(0xff2b2f77),
    Color(0xff483475),
    Color(0xffc4595f),
    Color(0xfff89c69),
    Color(0xffc4595f),
    Color(0xff483475),
    Color(0xff2b2f77),
    Color(0xff141852),
  ];//.reversed.toList();

  List<Alignment> alignments = [
    Alignment.bottomLeft,
    Alignment.bottomRight,
    Alignment.topRight,
    Alignment.topLeft,
  ];

  int index = 0;
  int duration = Dimens.gradientDuration;
  Color topColor = Colors.black;
  Color bottomColor = Color(0xff010101);
  Alignment begin = Alignment.topCenter;
  Alignment end = Alignment.bottomCenter;

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 10), () {
      setState(() {
        bottomColor = colors[index % colors.length];
      });
    });
    return Scaffold(
        body: Stack(
          children: [
            AnimatedContainer(
              duration: Duration(seconds: duration),
              onEnd: () {
                if(index < colors.length-2) {
                  // last gradient for sky (not sunset)
                  if(index == Dimens.openingGradientsNum){
                    Future.delayed(Duration(seconds: 1), (){
                      setState(() {
                        index += 1;
                        duration = Dimens.sunsetDuration;
                        bottomColor = colors[index % colors.length];
                        topColor = colors[(index + 1) % colors.length];
                      });
                    });
                  }
                  // make sunset better looking
                  else if(index == Dimens.openingGradientsNum + 1){
                    setState(() {
                      index += 1;
                      duration = Dimens.sunsetDuration~/2;
                      bottomColor = colors[index % colors.length];
                      topColor = colors[(index + 1) % colors.length];
                    });
                  }
                  else if(index == Dimens.openingGradientsNum + 2){
                    setState(() {
                      index += 1;
                      duration = Dimens.sunsetDuration~/4;
                      bottomColor = colors[index % colors.length];
                      topColor = colors[(index + 1) % colors.length];
                    });
                  }
                  // rest of sunset
                  else if(index > Dimens.openingGradientsNum){
                    setState(() {
                      index += 1;
                      duration = Dimens.sunsetDuration;
                      bottomColor = colors[index % colors.length];
                      topColor = colors[(index + 1) % colors.length];
                    });
                  }
                  // sky
                  else{
                    setState(() {
                      index += 1;
                      bottomColor = colors[index % colors.length];
                      topColor = colors[(index + 1) % colors.length];
                    });
                  }

                }
              },
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: begin, end: end, colors: [bottomColor, topColor])),
            ),
          ],
        ));
  }
}

